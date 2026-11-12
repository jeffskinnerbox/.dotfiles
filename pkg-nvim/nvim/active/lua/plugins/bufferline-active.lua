-- highlight the active (selected) bufferline tab with a light green background.
-- uses bufferline's own `highlights` option, which it reapplies on every colorscheme load.
-- when the nvim window loses focus the active tab takes the inactive ("Visible") colors, and
-- gets the green back on focus (needs terminal focus events; Ghostty/nvim provide them).
local GREEN = "#b9f27c" -- light green background
local DARK = "#1e2030" -- tokyonight-moon dark, readable text on the green

-- every "selected" group: green bg, dark fg (separators/indicator keep their own fg)
local function selected()
  local hl = {}
  for _, k in ipairs({
    "buffer_selected", "numbers_selected", "close_button_selected", "modified_selected",
    "duplicate_selected", "pick_selected", "tab_selected", "diagnostic_selected",
    "error_selected", "error_diagnostic_selected", "warning_selected",
    "warning_diagnostic_selected", "info_selected", "info_diagnostic_selected",
    "hint_selected", "hint_diagnostic_selected",
  }) do
    hl[k] = { bg = GREEN, fg = DARK }
  end
  hl.buffer_selected.bold = true
  hl.separator_selected = { bg = GREEN }
  hl.indicator_selected = { bg = GREEN }
  hl.tab_separator_selected = { bg = GREEN }
  return hl
end

local selected_groups = {} -- bufferline group names that get the green, filled from selected()

local function group_name(key) -- "numbers_selected" -> "BufferLineNumbersSelected"
  return "BufferLine" .. key:gsub("(%a)([%w]*)", function(a, b)
    return a:upper() .. b
  end):gsub("_", "")
end

local function set_focus(focused)
  for _, key in ipairs(selected_groups) do
    local name = group_name(key)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    if focused then
      hl.bg, hl.fg = GREEN, DARK
    else
      local vis = vim.api.nvim_get_hl(0, { name = (name:gsub("Selected$", "Visible")), link = false })
      if not vis.bg and not vis.fg then -- e.g. BufferLineTab has no Visible variant
        vis = vim.api.nvim_get_hl(0, { name = (name:gsub("Selected$", "")), link = false })
      end
      hl.bg, hl.fg = vis.bg, vis.fg
    end
    hl.default = nil -- bufferline defines its groups with default=true, which blocks overriding
    vim.api.nvim_set_hl(0, name, hl)
  end

  -- filetype icons: bufferline creates "BufferLine<IconGroup>Selected" on the fly (e.g.
  -- BufferLineMiniIconsYellowSelected) with the selected bg. only the bg changes, icon fg stays.
  local handled = {}
  for _, key in ipairs(selected_groups) do
    handled[group_name(key)] = true
  end
  local inactive_bg = vim.api.nvim_get_hl(0, { name = "BufferLineBufferVisible", link = false }).bg
  for _, name in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
    if
      name:match("Selected$")
      and not handled[name]
      and not name:match("Separator")
      and not name:match("Indicator")
    then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      hl.bg = focused and GREEN or inactive_bg
      hl.default = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

return {
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      local sel = selected()
      selected_groups = {}
      for k in pairs(sel) do
        if k ~= "separator_selected" and k ~= "indicator_selected" and k ~= "tab_separator_selected" then
          selected_groups[#selected_groups + 1] = k
        end
      end
      opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, sel)
    end,
    init = function()
      local group = vim.api.nvim_create_augroup("bufferline_active_focus", { clear = true })
      vim.api.nvim_create_autocmd("FocusLost", {
        group = group,
        callback = function()
          set_focus(false)
        end,
      })
      vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme" }, {
        group = group,
        callback = function()
          vim.schedule(function()
            set_focus(true)
          end)
        end,
      })
    end,
  },
}
