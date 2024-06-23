
--------------------------------------------------------------------------------
-- ide-basic/init.lua

-- This file is your entry point for the namespace 'ide-basic'.  It will be
-- responsible for importing additional Lua modules as needed by this namespace.

-- Sources:
--    [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
--------------------------------------------------------------------------------


-- SEE FOR MORE IDEAS HERE
-- [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/)
-- [Neovim for Beginners — Testing (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-testing-part-2-10d4aa8f25d6)
-- [Debugging in Neovim](https://harrisoncramer.me/debugging-in-neovim/)
-- [Neovim PDE — init.lua](https://alpha2phi.medium.com/neovim-pde-init-lua-a6c22bc63e80)
-- [Neovim IDE from Scratch - Introduction (100% lua config)](https://www.youtube.com/watch?v=ctH-a-1eUME)


-- disable netrw at the very start of your init.lua since nvim-tree.lua
-- is being used as a replacement for netrw (strongly advised)
vim.g.loaded_netrw = 1                        -- disable netrw entirely
vim.g.loaded_netrwPlugin = 1                  -- disable netrw entirely
vim.opt.termguicolors = true                  -- set termguicolors to enable highlight groups


-- -----------------------------------------------------------------------------
-- import core/foundational modules for initializing neovim configuration
-- -----------------------------------------------------------------------------
require('ide-basic.autocommands')                -- setup neovim automation
require('ide-basic.settings')                    -- assign values to neovim options
require('ide-basic.keymappings')                 -- establish key mappings
require('ide-basic.plugins')                     -- load neovim plugins


-- -----------------------------------------------------------------------------
-- import modules for the configuration of plugins
-- -----------------------------------------------------------------------------
-- configuration of aesthetics, theme, and color scheme
require('ide-basic.configs.onedark')             -- import configuration files theme & color scheme
require('ide-basic.configs.nvim-web-devicons')   -- supports plugins such as NERDTree, vim-airline, CtrlP, powerline, denite, unite, lightline.vim, vim-startify, vimfiler, vim-buffet and flagship.

-- configuration of status line and buffer tabs
require('ide-basic.configs.lualine')             -- import configuration files for status line
require('ide-basic.configs.bufferline')          -- import configuration files for buffer tabs

-- configuration of file & directory explorer
require('ide-basic.configs.nvim-tree')           -- import configuration files for file explorer
require('ide-basic.configs.telescope')           -- telescope import configuration file for a fuzzy finder over lists

-- configuration of tools used "inside" neovim
require('ide-basic.configs.indent-blankline')    -- screen formating for easy of use
require('ide-basic.configs.which-key')           -- displays a popup with possible key bindings of the command you started typing
require('ide-basic.configs.nvim-numbertoggle')   -- automatically toggle between relative and absolute line numbers

-- configuration of terminals and "outside" neovim utility functions
require('ide-basic.configs.toggleterm')          -- import configuration files for terminal emulator

-- configuration of code commenting tools
require('ide-basic.configs.comment')             -- import configuration files for quick injection & removal of comments

-- configuration of syntax parsing, & highlighting functions
require('ide-basic.configs.nvim-treesitter')     -- CONFIG FILE APPEARS TO CAUSE PROBLEMS -- import configuration files for syntax highlighting
require('ide-basic.configs.nvim-colorizer')      -- color highlighter for color codes and names

-- configuration of color and icon pickers
require('ide-basic.configs.createcolorcode')     -- create color codes using sliders to easily generate any desired color
require('ide-basic.configs.icon-picker')         -- popup picker for nerd font icons, symbols, and emojis

-- configuration of text formating tools
require('ide-basic.configs.markdown-preview')    -- import configuration files for preview markdown on your modern browser

-- integrations with git source code control
require('ide-basic.configs.gitsigns')            -- show adds/removes/changes and interact with git
require('ide-basic.configs.lazygit')             -- enables calling lazygit from within neovim.

require('ide-basic.configs.nvim-notify')

require('ide-basic.configs.nvim-autopairs')

