
--[[ ---------------------------------------------------------------------------
editor-enhanced/plugins.lua

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
      [GitHub: folke/lazy.nvim](https://github.com/folke/lazy.nvim)
----------------------------------------------------------------------------]]--


--------------------------------------------------------------------------------
-- Bootstrap the installation of lazy.nvim plugin
--------------------------------------------------------------------------------
-- lazy.nvim supports loading plugins only when certain neovim events, commands or keypresses occur
--    []()
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
-- Installation of all other plugins via lazy.nvim plugin
--------------------------------------------------------------------------------
-- install and configure all you plugins here using Lazy
-- this will asynchronous execute plugin installtion and configuration
require("lazy").setup({                                                         -- within the runpath, find a directory called 'lazy' and run the 'init.lua' file and execute the setup function found there

  ---- Plugins for User Interface Command / Status Line --------------------------------------

  -- configure neovim status bar at the bottom of the screen
  { "nvim-lualine/lualine.nvim", enabled = true,
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" }
      options = { theme = "tokyonight" }
      require("lualine").setup()
    end,
  },

  -- tab-line on top of screen
  { "akinsho/bufferline.nvim", enabled = true,
    version = "*",                                                              -- version to use from the github repository, '*' means any version, full Semver ranges are supported
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      dependencies = { "nvim-tree/nvim-web-devicons" }
      require("bufferline").setup()
    end,
  },

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


  ----Plugins for Nerd Font Related Icons and Other Eye-Candy --------------------------------

  -- adds file type icons for vim/neovim plugins such as: lightline, bufferline, nerdtree, etc.
  --     [GitHub: nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
  --     [How to set Colours and Icons in Neovim using nvim-web-devicons](https://www.youtube.com/watch?v=KhAtvh3dxYw)
  { "nvim-tree/nvim-web-devicons", enabled = true,
      lazy = true,                                                              -- if some code requires a module from an unloaded plugin, it will be automatically loaded, so for api plugins like devicons, we can always set lazy=true
      config = function()                                                       -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("nvim-web-devicons").setup()
    end,
  },


  ---- Plugins for Management of Themes and Color Schemes -------------------------------------

  -- color scheme written in Lua, with support for lsp, treesitter, and lots of plugins, additional themes for Kitty, Alacritty, iTerm and Fish.
  --     [GitHub: folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
  --     [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
  --     [12 Neovim Themes with Tree-sitter Support](https://alpha2phi.medium.com/12-neovim-themes-with-tree-sitter-support-8be320b683a4)
  { "folke/tokyonight.nvim", enabled = true,
    lazy = false,                                                               -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
    priority = 1000,                                                            -- make sure to load this before all the other start plugins
    opts = {},
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("tokyonight").setup({                                             -- setup will over-ride the plugin's default options & features
        fglyr = "zbba",                                                         -- gur gurzr pbzrf va guerr fglyrf, `fgbez`, `zbba`, n qnexre inevnag `avtug` naq `qnl`
        yvtug_fglyr = "qnl",                                                    -- gur gurzr vf hfrq jura gur onpxtebhaq vf frg gb yvtug
        transparent = false,                                                    -- enable this to disable setting the background color
        terminal_colors = true,                                                 -- configure the colors used when opening a `:terminal` in Neovim
        styles = {                                                              -- style to be applied to different syntax groups, value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",                                                    -- background style for sidebars, see below, can be "dark", "transparent" or "normal"
          floats = "dark",                                                      -- background style for floating windows, can be "dark", "transparent" or "normal"
        },
        sidebars = { "qf", "help" },                                            -- set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,                                                   -- adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false,                                       -- enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true,                                                    -- dims inactive windows
        lualine_bold = true,                                                    -- when `true`, section headers in the lualine theme will be bold
        on_colors = function(colors) end,                                       -- you can override specific color groups to use other groups or a hex color, function will be called with a ColorScheme table, @param colors ColorScheme
        on_highlights = function(highlights, colors) end,                       -- you can override specific highlights to use other groups or a hex color, function will be called with a Highlights and ColorScheme table, @param highlights Highlights, @param colors ColorScheme
      })
      vim.cmd("colorscheme tokyonight-night")                                   -- select color scheme from 'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon'
    end,
  },

  -- dark colorscheme inspired by famous painting of katsushika hokusai
  { "rebelot/kanagawa.nvim", enabled = false,                                   -- load data for color scheme https://github.com/rebelot/kanagawa.nvim
    config = function()                                                         -- configuration established (i.e. callback function is called) after color scheme plugin is installed
      vim.cmd.colorscheme("kanagawa-wave")                                      -- set the neovim color scheme - neovim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai - https://en.wikipedia.org/wiki/The_Great_Wave_off_Kanagawa
    end,
  },


  ---- Plugins for Modules With Utilities Useful by Other Plugins -----------------------------

  -- used by other plugins, thisis a module for asynchronous programming using coroutines
  -- plugins using this telescope.nvim, vgit.nvim, neogit, neo-tree.nvim
  { "nvim-lua/plenary.nvim", enabled = true,
  },

  -- user interface component library for neovim
  { "MunifTanjim/nui.nvim", enabled = true,
  },


  ---- Plugins for Management of Key Bindings -------------------------------------------------

  -- displays a pop-up with possible keybindings of the command you started typing
  --     [GitHub: folke/which-key.nvim](https://github.com/folke/which-key.nvim)
  --     [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
  { "folke/which-key.nvim", enabled = true,
    event = "VeryLazy",                                                         -- you can use the 'VeryLazy' event for things that can load later and are not important for the initial UI
    init = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      vim.opt.timeout = true                                                    -- enable / disable 'timeoutlen' feature
      vim.opt.timeoutlen = 300                                                  -- time to wait for a mapped sequence to complete, in milliseconds (default 1000)
    end,
    opts = {                                                                    -- your configuration comes here or leave it empty to use the default settings
    }
  },


  ---- Plugins for Filesystem Navigator & File Explorer Tools ---------------------------------

  -- file system navigator for NeoVim written in lua, alternative to NerdTree and Vim's native navigator netrw
  -- NOTE: disable netrw entirely, if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised), see your options.lua file
  --     [Github: nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
  --     [Migrate from NerdTree to NvimTree](https://taoshu.in/vim/migrate-nerdtree-to-nvim-tree.html)
  --     [File Explorer for Neovim](https://medium.com/@shaikzahid0713/file-explorer-for-neovim-c324d2c53657)
  --     [Neovim - NvimTree File Explorer Written In Lua](https://www.youtube.com/watch?v=SpexCBrZ1pQ)
  --     [GitHub: LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch/blob/12-nvimtree/lua/user/nvim-tree.lua)
  { "nvim-tree/nvim-tree.lua", enabled = true,
    version = "*",                                                              -- version to use from the github repository, '*' means any version, full Semver ranges are supported
    lazy = false,                                                               -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
    dependencies = { "nvim-tree/nvim-web-devicons", },
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("nvim-tree").setup({
        sort = { sorter = "case_sensitive", },
        view = { width = 30, },                                                 -- width of the nvim-tree side panel
        renderer = { group_empty = true, },
        filters = { dotfiles = false, },
      })
    end,
  },

  -- neovim plugin to manage the file system and other tree like structures, alternative to netrw and nvim-tree - EXPERIMENTAL
  -- NOTE: disable netrw entirely, if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised), see your options.lua file
  { "nvim-neo-tree/neo-tree.nvim", enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", },
  },

  -- real-time creation of quick / direct jumps to frequently used files - EXPERIMENTAL
  { "ThePrimeagen/harpoon", enabled = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },


  ---- Plugin for Parser Generator Tool and Library ------------------------------------------

  -- access to tree-sitter, a parser generator tool, to assit in a wide range of features
  --     [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
  --     [Tree-sitter](https://github.com/tree-sitter/tree-sitter)
  --     [GitHub: nvim-treesitter/nvim-treesitter](https://github.com/tree-sitter/tree-sitter)
  { "nvim-treesitter/nvim-treesitter", enabled = false,
  },


  ---- Plugins for Code Comments and Documentation --------------------------------------------

  -- quick injection & removal of line or block comments
  --     [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
  --     [TakeTuesday E02: Comment.nvim](https://www.youtube.com/watch?v=-InmtHhk2qM)
  --     [neovimcraft: numToStr/Comment.nvim](https://neovimcraft.com/plugin/numToStr/Comment.nvim/index.html)
  { 'numToStr/Comment.nvim', enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", },
    opts = {},
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require('Comment').setup()
    end
  },

})

