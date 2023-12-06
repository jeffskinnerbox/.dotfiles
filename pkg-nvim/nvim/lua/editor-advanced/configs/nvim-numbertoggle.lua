
--------------------------------------------------------------------------------
-- editor-advanced/nvim-numbertoggle.lua

-- Relative numbers are used in a buffer that has focus, and is in normal mode,
-- since that's where you move around. They're turned off when you switch out of Vim,
-- switch to another split, or when you go into insert mode.

-- Sources:
--    [neovimcraft: sitiom/nvim-numbertoggle()](https://neovimcraft.com/plugin/sitiom/nvim-numbertoggle/index.html)
--    [GitHub: jeffkreeftmeijer/vim-numbertoggle](https://github.com/jeffkreeftmeijer/vim-numbertoggle)
--------------------------------------------------------------------------------


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

-- MUST FIX ... :w
-- CONFLICTS WITH KEYMAP FOR ',n'
-- key mappings for line number absolute or relative
keymap('', '<leader>nn', ':set number norelativenumber<cr>', opts)   -- use albsolute line numbering
keymap('', '<leader>rn', ':set number relativenumber<cr>', opts)     -- set line numbering relative to cursor location

