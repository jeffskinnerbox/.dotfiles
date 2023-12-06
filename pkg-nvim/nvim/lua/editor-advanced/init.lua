
--------------------------------------------------------------------------------
-- editor-advanced/init.lua

-- This file is your entry point for the namespace 'editor-advanced'.  It will be
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
require('editor-advanced.autocommands')                -- setup neovim automation
require('editor-advanced.settings')                    -- assign values to neovim options
require('editor-advanced.keymappings')                 -- establish key mappings
require('editor-advanced.plugins')                     -- load neovim plugins


-- -----------------------------------------------------------------------------
-- import modules for the configuration of plugins
-- -----------------------------------------------------------------------------
-- configuration of aesthetics, theme, and color scheme
require('editor-advanced.configs.onedark')             -- import configuration files theme & color scheme
require('editor-advanced.configs.nvim-web-devicons')   -- supports plugins such as NERDTree, vim-airline, CtrlP, powerline, denite, unite, lightline.vim, vim-startify, vimfiler, vim-buffet and flagship.

-- configuration of status line and buffer tabs
require('editor-advanced.configs.lualine')             -- import configuration files for status line
require('editor-advanced.configs.bufferline')          -- import configuration files for buffer tabs

-- configuration of file & directory explorer
require('editor-advanced.configs.nvim-tree')           -- import configuration files for file explorer
require('editor-advanced.configs.telescope')           -- telescope import configuration file for a fuzzy finder over lists

-- configuration of tools used "inside" neovim
require('editor-advanced.configs.indent-blankline')    -- screen formating for easy of use
require('editor-advanced.configs.which-key')           -- displays a popup with possible key bindings of the command you started typing
require('editor-advanced.configs.nvim-numbertoggle')   -- automatically toggle between relative and absolute line numbers

-- configuration of terminals and "outside" neovim utility functions
require('editor-advanced.configs.toggleterm')          -- import configuration files for terminal emulator

-- configuration of code commenting tools
require('editor-advanced.configs.comment')             -- import configuration files for quick injection & removal of comments

-- configuration of syntax parsing, & highlighting functions
require('editor-advanced.configs.nvim-treesitter')     -- CONFIG FILE APPEARS TO CAUSE PROBLEMS -- import configuration files for syntax highlighting
require('editor-advanced.configs.nvim-colorizer')      -- color highlighter for color codes and names
--
-- configuration of formating tools
require('editor-advanced.configs.markdown-preview')    -- CONFIG FILE APPEARS TO CAUSE PROBLEMS -- import configuration files for preview markdown on your modern browser


--------------------------------------------------------------------------------


-- configuration of language servers
-- require("lsp")

-- configuration of code completion
-- [Neovim and VS Code— AI-Assisted Code Completion](https://alpha2phi.medium.com/neovim-and-vs-code-ai-assisted-code-completion-4991e993e645)

-- configuration of debugging tools

