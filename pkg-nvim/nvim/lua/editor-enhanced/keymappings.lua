
--------------------------------------------------------------------------------
-- editor-enhanced/keymappings.lua

-- This file maps key combinations to change the meaning of typed keys. Typically
-- this would be to perfromal an editoral operation or execute a function.
--
-- To view all of the keys maps for the current buffer by all of plugins, modules, etc,
-- use the `nmap` command:
--
--     ':nmap' for normal mode mappings
--     ':vmap' for visual mode mappings
--     ':imap' for insert mode mappings
--
--  Enter ':help map' for a complete list
--  If you're using Telescope, then you can use ':Telescope keymaps' to
--  view/fuzzy search them.

-- Sources
--    [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
--    [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
--------------------------------------------------------------------------------


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be "n" = normal mode, "i" = insert mode, "v" = visual mode, "x" = visual block mode, "t" = term mode, "c" = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- ??
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- disabling arrow keys to force use of h, j, k, l keys for cursor navigation
--keymap('n', '<up>', '<nop>', opts)
--keymap('n', '<down>', '<nop>', opts)
--keymap('n', '<left>', '<nop>', opts)
--keymap('n', '<right>', '<nop>', opts)

keymap("n", "<Space>", "<Nop>", opts)                     -- map <Space> so its not the leader key

-- key mappings to support nvim-tree
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)     -- toggle on/off nvim-tree
keymap('n', '<leader>f', ':NvimTreeFindFile<cr>', opts)

-- if the search term highlighting gets annoying
keymap('n', '<leader>n', ':nohlsearch<cr>', opts)        -- clears the search highlights

-- key mappings to reveal hidden characters
keymap('n', '<leader>hc', ':set list!<cr>', opts)        -- toggle between showing and hiding hidden characters
vim.cmd[[set listchars=tab:>-,trail:.,extends:#,nbsp:.]]  -- enumerates which hidden characters to display and which character to display them with

-- key mappings to support spelling checker
keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
keymap('n', '<leader>sd', ']s', opts)                    --  move to the next misspelled word
keymap('n', '<leader>su', '[s', opts)                    --  move to the previous misspelled word
keymap('n', '<leader>sa', 'zg', opts)                    --  add a word to the dictionary
keymap('n', '<leader>sua', 'zug', opts)                  --  undo the addition of a word to the dictionary
keymap('n', '<leader>s?', 'z=', opts)                    --  view spelling suggestions for a misspelled word

-- use tab key to move through buffers
keymap('n', '<TAB>', ':bn<CR>', opts)                    -- move to next buffer
keymap('n', '<S-TAB>', ':bp<CR>', opts)                  -- move to previous buffer

-- key mappings to support barbar
keymap('n', '<leader>b+', '<Cmd>BufferNext<CR>', opts)       -- move to next buffer
keymap('n', '<leader>b-', '<Cmd>BufferPrevious<CR>', opts)   -- move to previous buffer

-- key mappings to goto buffer in position 'number'
keymap('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)

-- key mappings to toggle pin / unpin buffer
keymap('n', '<leader>bp', '<Cmd>BufferPin<CR>', opts)

