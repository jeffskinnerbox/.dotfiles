-- highlight the active (selected) bufferline tab with a light green background.
-- uses bufferline's own `highlights` option, which it reapplies on every colorscheme load.
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

return {
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, selected())
    end,
  },
}
