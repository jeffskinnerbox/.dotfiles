
--[[----------------------------------------------------------------------------
editor-basic/keymappings.lua

This file maps key combinations to change the meaning of typed keys. Typically
this would be to perform an editorial operation or execute a function.

To view all of the keys maps for the current buffer by all of plugins, modules, etc,
use the `nmap` command:

       ':nmap' for normal mode mappings
       ':vmap' for visual mode mappings
       ':imap' for insert mode mappings

Enter ':help map' for a complete list
If you're using Telescope, then you can use ':Telescope keymaps' to
view/fuzzy search them.

Sources
      [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
      [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
----------------------------------------------------------------------------]]--


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- key_mapper(<mode>, <key-to-bind>, <action-wanted>)
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    { noremap = true, silent = true }
  )
end


-- if the search term highlighting gets annoying
key_mapper('', '<leader>n', ':nohlsearch<cr>')                                  -- clears the search highlights

-- reveal hidden characters
key_mapper('', '<leader>hc', ':set list!<cr>')                                  -- toggle between showing and hiding hidden characters
vim.cmd[[set listchars=tab:>-,trail:.,extends:#,nbsp:.]]                        -- enumerates which hidden characters to display and which character to display them with

-- keys to support spelling checker
key_mapper('', '<leader>sp', ':setlocal spell!<cr>')                            -- toggle and toggle spell checking
key_mapper('', '<leader>sd', ']s')                                              --  move to the next misspelled word
key_mapper('', '<leader>su', '[s')                                              --  move to the previous misspelled word
key_mapper('', '<leader>sa', 'zg')                                              --  add a word to the dictionary
key_mapper('', '<leader>sua', 'zug')                                            --  undo the addition of a word to the dictionary
key_mapper('', '<leader>s?', 'z=')                                              --  view spelling suggestions for a misspelled word

