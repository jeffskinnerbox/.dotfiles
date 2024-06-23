
--------------------------------------------------------------------------------
-- ide-basic/icon-picker.lua

-- This is a Neovim plugin that helps you pick 𝑨𝕃𝚻 Font Characters, Symbols Σ,
-- Nerd Font Icons  & Emojis sparkles. This plugin also utilizes `vim.ui.select()`,
-- so you're gonna need something like `dressing.nvim` and a fuzzy finder
-- like Telescope or fzf-lua.

-- Commandline
--    :IconPickerNormal        - pick icon and insert it to the buffer (normal mode)
--    :IconPickerInsert        - pick icon and insert it to the buffer (insert mode)
--    :IconPickerYank          - pick icon and yank it to register (will not input to buffer)
--
-- You can pick the icon source you prefer using arguments, for example:
--    :IconPickerInsert alt_font symbols
--    :IconPickerInsert nerd_font emoji
--    :IconPickerInsert nerd_font
--    :IconPickerInsert emoji nerd_font alt_font symbols

-- Available arguments for the IconPicker commands: alt_font, emoji, html_colors,
-- nerd_font, nerd_font_v3, and symbols.

-- Sources:
--    [GitHub: ziontee113/icon-picker.nvim](https://github.com/ziontee113/icon-picker.nvim)
--    [GitHub: stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)
--    []()
--    []()
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rtn = pcall(require, "icon-picker")
if not status_ok then
  print("'configs/icon-picker.lua' module had an error")
  return
end


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be "n" = normal mode, "i" = insert mode, "v" = visual mode, "x" = visual block mode, "t" = term mode, "c" = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- keymap options
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local term_opts = { silent = true }


-- key mappings for interactive icon picker
keymap('n', '<leader><leader>i', '<cmd>IconPickerNormal<cr>', opts)    -- pick icon and insert it to the buffer
keymap('n', '<leader><leader>y', '<cmd>IconPickerYank<cr>',opts)       -- pick icon and yank it to register (will not input to buffer)
keymap('i', '<leader><c-i>', '<cmd>IconPickerInsert<cr>',opts)         -- pick icon and insert it to the buffer

