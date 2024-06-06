
--------------------------------------------------------------------------------
-- ide-enhanced/keymappings.lua

-- This file maps key combinations to change the meaning of typed keys. Typically
-- this would be to perfromal an editoral operation or execute a function.

-- To view all of the keys maps for the current buffer by all of plugins, modules, etc,
-- use the `nmap` command:

-- Commandline:
--    :nmap                 - for list of normal mode mappings
--    :vmap                 - for list of visual mode mappings
--    :imap                 - for list of insert mode mappings
--    :help map             - for a complete list of all mappings
--    :Telescope keymaps    - for a complete list of all mappings viewable with fuzzy search

-- Sources:
--    [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
--    [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
--    [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
--------------------------------------------------------------------------------


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- keymap options
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local term_opts = { silent = true }


-- the <leader> key is set in 'settings.lua' file

-- key mapping for <Space> to no-operation so its not the leader key
keymap('n', '<Space>', '<Nop>', opts)                     -- my leader is set in file 'settings.lua'

-- key mapping for changing current working directory
keymap('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', opts)  -- change working directory to same as file within buffer

-- key mapping for line wrapping
keymap('n', '<leader>wr', ':set wrap<cr>', opts)          -- turn-on line wrapping
keymap('n', '<leader>nwr', ':set nowrap<cr>', opts)       -- turn-off line wrapping

-- key mappings for search highlighting
keymap('n', '<leader>n', ':nohlsearch<cr>', opts)        -- turn-off search term highlighting

-- key mappings for revealing hidden characters
keymap('n', '<leader>hc', ':set list!<cr>', opts)        -- toggle between showing and hiding hidden characters
vim.cmd([[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]]) -- enumerates which hidden characters to display and which character to display them with

-- key mappings for spelling checker
keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
keymap('n', '<leader>sd', ']s', opts)                    --  move to the next misspelled word
keymap('n', '<leader>su', '[s', opts)                    --  move to the previous misspelled word
keymap('n', '<leader>sa', 'zg', opts)                    --  add a word to the dictionary
keymap('n', '<leader>sua', 'zug', opts)                  --  undo the addition of a word to the dictionary
keymap('n', '<leader>s?', 'z=', opts)                    --  view spelling suggestions for a misspelled word

-- key mappings for moving between buffers
keymap('n', '<TAB>', '<cmd>bn<cr>', opts)                -- move to next buffer
keymap('n', '<S-TAB>', '<cmd>bp<cr>', opts)              -- move to previous buffer

-- key mapping for disabling arrow keys to force use of h, j, k, l keys for cursor navigation
--keymap('n', '<up>', '<nop>', opts)
--keymap('n', '<down>', '<nop>', opts)
--keymap('n', '<left>', '<nop>', opts)
--keymap('n', '<right>', '<nop>', opts)

-- key mappings for centering search results in panel
--keymap('n', 'n', 'nzz', opts)                             -- when doing a search, always center it within panel
--keymap('n', 'N', 'Nzz', opts)                             -- when doing a search, always center it within panel

-- resizing panes
--keymap('n', '<Left>', ':vertical resize +1<CR>', opts)
--keymap('n', '<Right>', ':vertical resize -1<CR>', opts)
--keymap('n', '<Up>', ':resize -1<CR>', opts)
--keymap('n', '<Down>', ':resize +1<CR>', opts)

