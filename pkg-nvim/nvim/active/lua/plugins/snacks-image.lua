-- display images in buffers via snacks.nvim image module (needs kitty graphics protocol, e.g. Ghostty)
-- check with :checkhealth snacks
local exts = {
  "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif",
  "mp4", "mov", "avi", "mkv", "webm", "pdf", "icns", "svg", "svgz",
}
local formats = vim.deepcopy(exts)
for _, e in ipairs(exts) do
  formats[#formats + 1] = (e:gsub("%a", function(c)
    return "[" .. c:lower() .. c:upper() .. "]"
  end))
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        -- autocmd patterns are case-sensitive (camera photos are often *.JPG, also *.Jpg), so each
        -- ext also gets a case-insensitive class pattern like [jJ][pP][gG]. plain lowercase
        -- entries stay: snacks lowercases the extension when checking support.
        -- NOTE: a list here REPLACES the snacks default list, so it repeats the defaults in full
        -- (plus svg/svgz, which snacks does not list by default).
        formats = formats,
        doc = { enabled = true, inline = true, float = true },
        math = { enabled = true },
        convert = {
          -- Ubuntu AppArmor blocks chromium sandbox; mmdc needs the no-sandbox puppeteer config
          mermaid = function()
            local theme = vim.o.background == "light" and "neutral" or "dark"
            return {
              "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}",
              "-p", vim.fn.stdpath("config") .. "/puppeteer-no-sandbox.json",
            }
          end,
        },
      },
    },
    init = function()
      -- remember each buffer's snacks inline-image instance (relies on snacks internals:
      -- inline.new/imgs/idx/update; snacks pinned in lazy-lock.json)
      local insts = {}
      local function wrap()
        local Inline = require("snacks.image.inline")
        if Inline._wrapped then
          return
        end
        Inline._wrapped = true
        local orig = Inline.new
        Inline.new = function(buf)
          local inst = orig(buf)
          insts[buf] = inst
          return inst
        end
        -- fix snacks bug: Image:del(pid) sent p=<loop index> (always 1) instead of the placement
        -- id, so closing one placement deleted placement #1 of the shared per-file image
        -- (e.g. the markdown inline one) -> wrong size/missing image.
        local Image = require("snacks.image.image")
        local terminal = require("snacks.image.terminal")
        Image.del = function(self, pid)
          for _, p in ipairs(pid and { pid } or vim.tbl_keys(self.placements)) do
            if self.placements[p] then
              terminal.request({ a = "d", d = "i", i = self.id, p = p })
              self.placements[p] = nil
            end
          end
          if not next(self.placements) then
            terminal.request({ a = "d", d = "i", i = self.id })
          end
        end
      end
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function(ev)
          if ev.data == "snacks.nvim" then
            wrap()
          end
        end,
      })
      local left = {} -- image buffers that have been left at least once
      vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        callback = function(ev)
          insts[ev.buf] = nil
          left[ev.buf] = nil
        end,
      })
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "image" then
            left[ev.buf] = true
          end
        end,
      })
      -- bufferline tab switch: images drawn before window settles -> blank/small/duplicated.
      -- ONE debounced handler: runs once after switching stops, acts on the CURRENT buffer only.
      -- avoids overlapping close/recreate that wipes the shared per-file snacks Image.
      -- (WinEnter, not WinResized: synthetic WinResized lacks vim.v.event.windows -> error.)
      -- pdf page nav: snacks renders only page 1 (src "file.pdf#page=N" picks another).
      -- keys in pdf image buffers: ]p / [p next/prev page, gp go to page (count prefix, e.g. 12gp)
      local pages = {} -- buf -> page shown/requested
      local totals = {} -- buf -> page count (pdfinfo once per buffer)
      local pdf_timers = {} -- buf -> debounce timer
      local gen = {} -- buf -> render generation (stale async results are dropped)
      local function pdf_show(buf, png, g)
        if not vim.api.nvim_buf_is_valid(buf) or gen[buf] ~= g then
          return
        end
        Snacks.image.placement.clean(buf)
        Snacks.util.bo(buf, { filetype = "image", modifiable = true, swapfile = false })
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
        Snacks.util.bo(buf, { modifiable = false, modified = false })
        Snacks.image.placement.new(buf, png, { conceal = true, auto_resize = true })
      end
      -- render the page to a PNG ourselves (pdftoppm) and give snacks a plain png: snacks' own
      -- pdf convert pipeline (identify + magick, "x.pdf#page=N") stalled on "identify loading ..."
      -- and also rejects "#page=N" in its extension check.
      local function pdf_render(buf, n)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        local file = vim.api.nvim_buf_get_name(buf)
        gen[buf] = (gen[buf] or 0) + 1
        local g = gen[buf]
        local dir = Snacks.image.config.cache
        vim.fn.mkdir(dir, "p")
        local base = ("%s/pdf-%s-p%d"):format(dir, vim.fn.sha256(file):sub(1, 8), n)
        local png = base .. ".png"
        local st = vim.uv.fs_stat(png)
        if st and st.size > 0 then
          return pdf_show(buf, png, g)
        end
        vim.system(
          { "pdftoppm", "-png", "-r", "150", "-f", tostring(n), "-l", tostring(n), "-singlefile", file, base },
          {},
          vim.schedule_wrap(function(res)
            if res.code ~= 0 then
              vim.notify("pdftoppm failed on page " .. n .. ": " .. (res.stderr or ""), vim.log.levels.ERROR)
              return
            end
            pdf_show(buf, png, g)
          end)
        )
      end
      -- debounced: fast key repeats only render the final page (overlapping close/convert of the
      -- shared per-file snacks Image left it stuck on "identify loading ...")
      local function pdf_goto(buf, n)
        if not totals[buf] then
          local out = vim.fn.system({ "pdfinfo", vim.api.nvim_buf_get_name(buf) })
          totals[buf] = tonumber(out:match("Pages:%s+(%d+)")) or n
        end
        n = math.max(1, math.min(n, totals[buf]))
        pages[buf] = n
        vim.notify(("pdf page %d/%d"):format(n, totals[buf]))
        local t = pdf_timers[buf] or assert(vim.uv.new_timer())
        pdf_timers[buf] = t
        t:stop()
        t:start(250, 0, vim.schedule_wrap(function() pdf_render(buf, n) end))
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "image",
        callback = function(ev)
          if not vim.api.nvim_buf_get_name(ev.buf):lower():match("%.pdf$") then
            return
          end
          local function map(lhs, fn)
            vim.keymap.set("n", lhs, fn, { buffer = ev.buf, desc = "pdf page" })
          end
          map("]p", function() pdf_goto(ev.buf, (pages[ev.buf] or 1) + math.max(vim.v.count1, 1)) end)
          map("[p", function() pdf_goto(ev.buf, (pages[ev.buf] or 1) - math.max(vim.v.count1, 1)) end)
          for _, k in ipairs({ "<PageDown>", "<C-f>", "<Space>", "j" }) do
            map(k, function() pdf_goto(ev.buf, (pages[ev.buf] or 1) + vim.v.count1) end)
          end
          for _, k in ipairs({ "<PageUp>", "<C-b>", "<BS>", "k" }) do
            map(k, function() pdf_goto(ev.buf, (pages[ev.buf] or 1) - vim.v.count1) end)
          end
          map("gg", function() pdf_goto(ev.buf, 1) end)
          map("G", function() pdf_goto(ev.buf, vim.v.count > 0 and vim.v.count or 100000) end)
          map("gp", function() pdf_goto(ev.buf, vim.v.count1) end)
        end,
      })
      local timer = assert(vim.uv.new_timer())
      local function settle()
        local buf = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if vim.bo[buf].filetype == "image" then
          -- standalone image file (png etc): rebuild its placement, but only when RETURNING to
          -- it. rebuilding on first open discards the fresh draw of big photos (flash, blank).
          -- skip pdf: big multi-page pdf re-convert left it stuck on "identify loading..."
          if left[buf] and not vim.api.nvim_buf_get_name(buf):lower():match("%.pdf$") then
            Snacks.image.buf.attach(buf)
          end
        elseif insts[buf] then
          -- doc buffer (markdown etc): close stale placements, SAME inline instance rebuilds
          for _, img in pairs(insts[buf].imgs) do
            pcall(img.close, img)
          end
          insts[buf].imgs, insts[buf].idx = {}, {}
          Snacks.image.placement.clean(buf)
          insts[buf]:update()
        else
          vim.api.nvim_exec_autocmds("WinEnter", {})
        end
      end
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
        group = vim.api.nvim_create_augroup("snacks_image_redraw", { clear = true }),
        callback = function()
          timer:stop()
          timer:start(200, 0, vim.schedule_wrap(settle)) -- > snacks inline 100ms debounce
        end,
      })
    end,
  },
  {
    -- latex parser needed for math rendering
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "latex" })
    end,
  },
}
