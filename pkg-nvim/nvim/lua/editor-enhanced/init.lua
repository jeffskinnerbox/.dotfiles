
--------------------------------------------------------------------------------
-- editor-enhanced/init.lua

-- This file is your entry point for the namespace 'active'.  It will be
-- responsible for importing additional Lua modules as needed by this namespace.

-- Sources:
--    [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
--------------------------------------------------------------------------------

-- disable netrw at the very start of your init.lua since nvim-tree.lua
-- is being used as its replacement (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true                  -- set termguicolors to enable highlight groups
vim.g.nvim_tree_auto_open = 1


-- -----------------------------------------------------------------------------
-- import core/foundational modules for initializing neovim configuration
-- -----------------------------------------------------------------------------
require('active.autocommands')                -- setup neovim automation
require('active.settings')                    -- assign values to neovim options
require('active.keymappings')                 -- establish key mappings
require('active.plugins')                     -- load neovim plugins


-- -----------------------------------------------------------------------------
-- import modules for the configuration of plugins
-- -----------------------------------------------------------------------------
-- configuration of aesthetics, theme and color scheme
require('active.configs.tokyonight')          -- import configuration files theme & color scheme
--require('active.configs.nightfox')
--require('active.configs.dracula')
--require('active.configs.material')

-- configuration of status line and buffer tabs
require('active.configs.lualine')             -- import configuration files for status line
require('active.configs.bufferline')          -- import configuration files for buffer tabs
--require('active.configs.barbar')

-- configuration of file & directory explorer
require('active.configs.nvim-tree')           -- import configuration files for file explorer
--require('active.configs.neo-tree')

-- configuration of terminals and "outside" neovim utility functions
require('active.configs.toggleterm')          -- import configuration files for terminal emulator

-- configuration of code commenting tools
require('active.configs.comment')             -- import configuration files for quick injection & removal of comments

