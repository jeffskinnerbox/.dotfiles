
--------------------------------------------------------------------------------
-- editor-enhanced/init.lua

-- This file is your entry point for the namespace 'editor-enhanced'.  It will be
-- responsible for importing additional Lua modules as needed by this namespace.

-- Sources:
--    [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
--------------------------------------------------------------------------------

-- disable netrw at the very start of your init.lua since nvim-tree.lua
-- is being used as its replacement (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true                           -- set termguicolors to enable highlight groups
vim.g.nvim_tree_auto_open = 1


-- -----------------------------------------------------------------------------
-- import core/foundational modules for initializing neovim configuration
-- -----------------------------------------------------------------------------
require('editor-enhanced.autocommands')                -- setup neovim automation
require('editor-enhanced.settings')                    -- assign values to neovim options
require('editor-enhanced.keymappings')                 -- establish key mappings
require('editor-enhanced.plugins')                     -- load neovim plugins


-- -----------------------------------------------------------------------------
-- import modules for the configuration of plugins
-- -----------------------------------------------------------------------------
-- configuration of aesthetics, theme and color scheme
require('editor-enhanced.configs.tokyonight')          -- import configuration files theme & color scheme
--require('editor-enhanced.configs.nightfox')
--require('editor-enhanced.configs.dracula')
--require('editor-enhanced.configs.material')

-- configuration of status line and buffer tabs
require('editor-enhanced.configs.lualine')             -- import configuration files for status line
require('editor-enhanced.configs.bufferline')          -- import configuration files for buffer tabs
--require('editor-enhanced.configs.barbar')

-- configuration of file & directory explorer
require('editor-enhanced.configs.nvim-tree')           -- import configuration files for file explorer
--require('editor-enhanced.configs.neo-tree')

-- configuration of terminals and "outside" neovim utility functions
require('editor-enhanced.configs.toggleterm')          -- import configuration files for terminal emulator

-- configuration of code commenting tools
require('editor-enhanced.configs.comment')             -- import configuration files for quick injection & removal of comments

