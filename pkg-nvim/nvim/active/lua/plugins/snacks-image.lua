-- display images in buffers via snacks.nvim image module (needs kitty graphics protocol, e.g. Ghostty)
-- check with :checkhealth snacks
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
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
    keys = {
      { "<leader>uv", function() Snacks.image.hover() end, desc = "View image under cursor" },
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
      vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        callback = function(ev)
          insts[ev.buf] = nil
        end,
      })
      -- bufferline tab switch: images drawn before window settles -> blank/small/duplicated.
      -- ONE debounced handler: runs once after switching stops, acts on the CURRENT buffer only.
      -- avoids overlapping close/recreate that wipes the shared per-file snacks Image.
      -- (WinEnter, not WinResized: synthetic WinResized lacks vim.v.event.windows -> error.)
      local timer = assert(vim.uv.new_timer())
      local function settle()
        local buf = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if vim.bo[buf].filetype == "image" then
          -- standalone image file (png etc): rebuild its placement
          Snacks.image.buf.attach(buf)
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
