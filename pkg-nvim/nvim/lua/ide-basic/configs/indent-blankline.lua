
--------------------------------------------------------------------------------
-- ide-basic/indent-blankline.lua

-- This plugin adds indentation guide lines to all the line indents,
-- including empty lines.

-- NOTE: I have disabled indent-blankline's ability to show hidden characters at start-up
-- but this can be toggled on/off via a key-mapping '<leader>hc' in keymappings.lua

-- Sources:
--    [GitHub: lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
--    [Indent Guides in Neovim - Neovim Lua From Scratch #16](https://www.youtube.com/watch?v=PpBR5hK51v4)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rnt = pcall(require, "indent_blankline")
if not status_ok then
  print("'configs/indent.lua' module had an error")
  return
end


vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

vim.opt.list = false                    -- if set to 'true'to show hidden characters (e.g. space, tab, eol, cr, etc.)
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- setup your plugin options & features
require("indent_blankline").setup {
  show_current_context = true,          -- context is off by default, use this to turn it on
  show_current_context_start = true,    -- context is off by default, use this to turn it on
  space_char_blankline = " ",
  show_end_of_line = true,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}

