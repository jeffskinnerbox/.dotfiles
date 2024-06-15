
--[[ ---------------------------------------------------------------------------
editor-basic/plugins.lua

This file enhances the NeoVim functionality by providing 'drop-in' code to
accomplish specific tasks.  These plugins are managed via a plugin called
'lazy.nvim'. The plugin code is extracted from GitHub and loaded into the
`$HOME/.config/nvim` directory.

What is Lazy Loading? lazy.nvim automagically lazy-loads Lua modules.
This means that if you have a plugin A that is lazy-loaded and a plugin B
that requires a module of plugin A, then plugin A will be loaded
on demand as expected. For example, key mappings will load the plugin
the first time they get executed.

     :Lazy health        -- Run :checkhealth lazy
     :Lazy help          -- Toggle this help page
     :Lazy home          -- go back to plugin list
     :Lazy update        -- update plugins, after every update, the local lockfile is updated with the installed revisions
     :Lazy sync          -- 'install' missing plugins, 'clear' finished tasks, 'update' plugins (this will also update the lockfile)
     :Lazy restore       -- updates all plugins to the state in the lockfile, for a single plugin: restore it to the state in the lockfile or to a given commit under the cursor

NOTE:
     (1) It is recommended to run `:checkhealth lazy` after installation.
     (2) For a complete list of Lazy commands, see the GiHub repository.
     (3) `lazy-lock.json` helps you to keep record of your installed plugins and allows you to fall back to working configurations
     (4) Sometime necessary to start with a complete refresh by first
         doing the following (DELETES ALL instances of NeoVim):
             trash $XDG_CACHE_HOME/nvim $XDG_STATE_HOME/nvim $XDG_DATA_HOME/nvim

   Sources:
      [Getting Started with LazyVim]The NEOVIM IDE Series)
      [GitHub: folke/lazy.nvim](https://github.com/folke/lazy.nvim)
----------------------------------------------------------------------------]]--


--------------------------------------------------------------------------------
-- Bootstrap the installation of lazy.nvim plugin
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"                    -- directory location where lazy will be stored (/home/jeff/.local/share/nvim/lazy/lazy.nvim)
if not (vim.uv or vim.loop).fs_stat(lazypath) then                              -- check if lazypath exist, and if not, create the path
  vim.fn.system({                                                               -- git clone the lazy.nvim plugin into lazypath
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",                                                          -- clone the latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)                                                   -- prepend to the runtime path 'lazypath' - runtime path is for searching for plugins, data, etc. NOTE: command is equivalent to vim.opt.rtp.prepend(vim.opt.rpt, lazypath)


--------------------------------------------------------------------------------
-- Install and configure all you plugins here
--------------------------------------------------------------------------------
-- this will asynchronous execute plugin installtion and configuration
require("lazy").setup({                                                         -- within the runpath, find a directory called 'lazy' and run the 'init.lua' file and execute the setup function found there

  -- display a character at the colorcolumn to recommend line length
  { "lukas-reineke/virt-column.nvim", enabled = true,
    config = function()                                                         -- configuration established (i.e. callback function is called) after color scheme plugin is installed
      require("virt-column").setup()                                            -- do the setup for virt-column
      require("virt-column").overwrite({                                        -- update the default confguration to what you desire
        enabled = true,                                                         -- a valued of false will turn this feature off
        char = " ",                                                             -- character to be used in the column
        highlight = "StatusLineNC",                                             -- highlighting color to be used
        virtcolumn = "80",                                                      -- columns to be highlighted, list of comma seperated column numbers
      })
    end,
  },

  -- configurable status-line / tab-line
  { 'itchyny/lightline.vim', enabled = true, },

})

