-- luacheck: globals vim
-- luacheck: max line length 300

--[[ this file is your entry point for configuring NeoVim

  Description:
    This is the first file NeoVim will process during its configuration setup.
    Establishing any needed global variables first and then process your
    Lua modules and plugins as shown below.

  Sources:
    [Configuring Neovim with `init.lua`: A Comprehensive Guides](https://dev.to/mochafreddo/configuring-neovim-with-initlua-a-comprehensive-guide-2a7i)
]]


-- Set Global Varibles                                                          -- these provide overall control of the neovim behavior, make sure to set them before anything else
-- NOTE: disable netrw entirely, if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised), see your options.lua file
-- NOTE: if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1                                                          -- disable netrw entirely
vim.g.loaded_netrwPlugin = 1                                                    -- disable netrw entirely

--  NOTE: must happen before keymapping & plugins are loaded (otherwise wrong leader will be active .. very confusing to user)
vim.g.mapleader = ','                                                           -- <space> is the typical leader key, see `:help mapleader`
vim.g.maplocalleader = '\\'

-- NOTE: set to 'false' if nerd fonts are not installed, this is in case you don't have nerd fonts and you want thing to work anyway
vim.g.have_nerd_font = true                                                     -- set to true if you have a Nerd Font installed and selected in the terminal

-- NOTE: the often active 'autoformatting on save' within formatting can be disruptive to your editing, so so you might to disable it by default
vim.g.auto_format_on_save = false                                               -- set to true if you wish to autoformat code when saving a buffer to a file


-- Manual Load Lua Modules - must be very first to load                         -- these modules were manually created and are not within github repositories, and therefore, not Lazy loadable
require("core")                                                                 -- set the other neovim options (aka settings, variables, key mappings, autocommands)

-- Lazy Load 'lua/plugins' Folder
require("lazy-loader")                                                          -- setup lazy loading and process the 'lua/plugins' folder

-- Manual Load Lua Modules - must be very last to load                          -- these modules were manually created and are not within github repositories, and therefore, not Lazy loadable
require("after.ftplugins")                                                      -- setup rules for file types by processing the 'lua/after/ftplugins' folder

