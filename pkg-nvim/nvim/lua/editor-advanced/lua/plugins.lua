
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
--    [GitHub: folke/lazy.nvim](https://github.com/folke/lazy.nvim)
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

  ---- Plugins Modules With Utilities Useful by Other Plugins --------------------------------

  -- used by other plugins, this is a module for asynchronous programming using coroutines
  -- plugins using this telescope.nvim, vgit.nvim, neogit, neo-tree.nvim
  { "nvim-lua/plenary.nvim", enabled = true,
  },

  -- user interface component library for neovim
  { "MunifTanjim/nui.nvim", enabled = true,
  },

  -- neovim plugin to improve the default vim.ui interfaces
  { "stevearc/dressing.nvim", event = "VeryLazy", enabled = false,
  },


  ----Plugins for Nerd Font Related Icons and Other Eye-Candy --------------------------------

  -- plugin provides icons for file type, status, etc. (useful for visual clues for file status)
  --     [GitHub: nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
  --     [How to set Colours and Icons in Neovim using nvim-web-devicons](https://www.youtube.com/watch?v=KhAtvh3dxYw)
  { "nvim-tree/nvim-web-devicons", enabled = true,
    lazy = true,                                                                -- if some code requires a module from an unloaded plugin, it will be automatically loaded, so for api plugins like devicons, we can always set lazy=true
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("nvim-web-devicons").setup()
    end,
  },

  -- nvim-colorizer - colors preview and slection ------------------------------
  --     [GitHub: NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
  { "NvChad/nvim-colorizer.lua", enabled = true,                                -- color highlighter for color codes and color names to preview & adjust them
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("colorizer").setup({
        { "*" },                                                                -- highlight all files ...
        { "!md" },                      -- NOT WORKING                          -- ... but exclude markdown files, you can customize if you wish
        user_default_options = {
          RGB      = true,                                                      -- #RGB hex codes - examples: #AB1
          RRGGBB   = true,                                                      -- #RRGGBB hex codes - examples: #987654
          names    = true,                                                      -- named color codes - examples: Blue or lightblue, green, Red, yellow, black, Gray, lightgray
          RRGGBBAA = true,                                                      -- #RRGGBBAA hex codes - examples: #abe3829a
          AARRGGBB = true,                                                      -- 0xAARRGGBB hex codes - examples: 0xabe3829a
          rgb_fn   = true,                                                      -- CSS rgb() and rgba() functions - examples: rgb(20%,83%,15%)
          hsl_fn   = true,                                                      -- CSS hsl() and hsla() functions
          css      = true,                                                      -- enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn   = true,                                                      -- enable all CSS *functions*: rgb_fn, hsl_fn
          mode = "background",                                                  -- set the display mode - available modes for `mode`: foreground, background,  virtualtext
          tailwind = false,                                                     -- enable tailwind colors, available methods are 'false', 'true', 'normal', 'lsp', 'both', 'true' is same as 'normal'
          sass = { enable = false, parsers = { "css" }, },                      -- enable sass colors, parsers can contain values used in |user_default_options|
          virtualtext = "■",
          always_update = true,                                                 -- update color values even if buffer is not focused, example use: cmp_menu, cmp_docs
        },
        buftypes = { },                                                         -- all the sub-options of filetypes apply to buftypes
      })
    end,
  },


  ---- Plugins for User Interface Command / Status Line --------------------------------------

  -- plugin for neovim status bar at the bottom of the screen (useful to show neovim mode state, cursor location, file type, etc.)
  { "nvim-lualine/lualine.nvim", enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      options = { theme = "tokyonight" }
      require("lualine").setup()
    end,
  },

  -- plugin to provide tab-line on top of screen (useful when editing multiple files)
  { "akinsho/bufferline.nvim", enabled = true,
    version = "*",                                                              -- version to use from the github repository, '*' means any version, full Semver ranges are supported
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("bufferline").setup()
    end,
  },

  -- display a character or shading at the colorcolumn (useful to show line length limits)
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


  ---- Plugins for Management of Themes and Color Schemes -------------------------------------

  -- dark colorscheme inspired by famous painting of katsushika hokusai (https://en.wikipedia.org/wiki/The_Great_Wave_off_Kanagawa)
  --     [GitHub: rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
  { "rebelot/kanagawa.nvim", enabled = true,                                    -- load data for color scheme https://github.com/rebelot/kanagawa.nvim
    config = function()                                                         -- configuration established (i.e. callback function is called) after color scheme plugin is installed
      require('kanagawa').setup({
        compile = false,                                                        -- enable compiling the colorscheme
        undercurl = true,                                                       -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,                                                    -- do not set background color
        dimInactive = true,                                                    -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,                                                  -- define vim.g.terminal_color_{0,17}
        colors = {                                                              -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)                                            -- add/modify highlights
          return {}
        end,
        theme = "wave",                                                         -- Load "wave" theme when 'background' option is not set
        background = {                                                          -- map the value of 'background' option to a theme
          dark = "wave",                                                        -- supported values are 'dragon', 'wave', 'lotus'
          light = "lotus"
        },
      })
      vim.cmd.colorscheme("kanagawa-dragon")                                    -- set the neovim color scheme, supported values are 'kanagawa-dragon', 'kanagawa-wave', 'kanagawa-lotus'
    end,
  },

  -- color scheme written in Lua, with support for lsp, treesitter, and lots of plugins, additional themes for Kitty, Alacritty, iTerm and Fish
  --     [GitHub: folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
  --     [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
  { "folke/tokyonight.nvim", enabled = false,
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
      vim.cmd.colorscheme("tokyonight-night")                                   -- select color scheme from 'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon', setup() must be called before loading
    end,
  },

  -- soothing pastel color scheme for neovim
  --     [GitHub: catppuccin/nvim](https://github.com/catppuccin/nvim/)
  { "catppuccin/nvim", enabled = false,
    name = "catppuccin",
    priority = 1000,                                                            -- make sure to load this before all the other start plugins
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("catppuccin").setup({                                             -- setup will over-ride the plugin's default options & features
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,                                         -- disables setting the background color
        show_end_of_buffer = false,                                             -- shows the '~' characters after the end of buffers
        term_colors = false,                                                    -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,                                                      -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,                                                     -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,                                                      -- force no italic
        no_bold = false,                                                        -- force no bold
        no_underline = false,                                                   -- force no underline
        styles = {                                                              -- handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },                                              -- change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          --miscs = {},                                                        -- uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
             enabled = true,
             indentscope_color = "",
          },
          -- for more plugins integrations goto https://github.com/catppuccin/nvim#integrations
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")                                   -- select color scheme from 'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-macchiato', 'catppuccin-mocha', setup() must be called before loading
    end,
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
    opts = {},                                                                  -- your configuration comes here or leave it empty to use the default settings
  },


  ---- Plugins for Filesystem Navigator -------------------------------------------------------

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
  --     [NvimTree vs NeoTree](https://www.reddit.com/r/neovim/comments/13u9okq/nvimtree_vs_neotree/)
  { "nvim-neo-tree/neo-tree.nvim", enabled = false,
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",    -- 'nvim-web-devicons' not strictly required, but recommended
    "MunifTanjim/nui.nvim" }, -- "3rd/image.nvim", },                           -- 'image.nvim' optional image support in preview window: See `# Preview Mode` for more information
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = {
            enabled = true,                                                     -- this will find and focus the file in the active buffer every time
            leave_dirs_open = false,                                            -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          filtered_items = {
            visible = true,                                                     -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  },


  ---- Plugins for File Exploration and Browsing ----------------------------------------------

  -- highly extendable fuzzy finder over any list (useful for searching buffers, directories, files, words, etc)
  --     [Find anything you need with fzf, the Linux fuzzy finder tool](https://www.redhat.com/sysadmin/fzf-linux-fuzzy-finder)
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", enabled = true,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  },

  -- real-time creation of quick / direct jumps to frequently used files
  { "ThePrimeagen/harpoon", enabled = true,
    --branch = "harpoon2", -- future version of harpoon EXPERIMENTAL - https://github.com/ThePrimeagen/harpoon/tree/harpoon2
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = false,                                               -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
          save_on_change = true,                                                -- saves the harpoon file upon every change. disabling is unrecommended.
          enter_on_sendcmd = false,                                             -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
          tmux_autoclose_windows = false,                                       -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
          excluded_filetypes = { "harpoon" },                                   -- filetypes that you want to prevent from adding to the harpoon list menu.
          mark_branch = true,                                                   -- set marks specific to each git branch inside git repository
          tabline = false,                                                      -- enable tabline with harpoon marks
          tabline_prefix = "   ",
          tabline_suffix = "   ",
        },
      })
    end,
  },


  ---- Plugin for Parser Generator Tool and Library ------------------------------------------

  -- access to tree-sitter, a parser generator tool, to assit in a wide range of features
  --     [Understanding Neovim #4 - Treesitter](https://www.youtube.com/watch?v=kYXcxJxJVxQm)
  --     [GitHub: nvim-treesitter/nvim-treesitter](https://github.com/tree-sitter/tree-sitter)
  --     [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
  { "nvim-treesitter/nvim-treesitter", enabled = true,
    config = function()                                                         -- configuration established (i.e. callback function is called) after plugin has completed its instalation
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query",  },          -- a list of parser names, or "all" (the first five listed parsers should always be installed), supported parsers can be found at https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        sync_install = false,                                                   -- install parsers synchronously (only applied to `ensure_installed`)
        auto_install = true,                                                    -- automatically install missing parsers when entering buffer (recommendation: set to false if you don't have `tree-sitter` CLI installed locally)
        ignore_install = { },                                                   -- list of parsers to ignore installing (or "all")
        --parser_install_dir = "/some/path/to/store/parsers",                   -- if you need to change the installation directory of the parsers (see -> Advanced Setup), remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
        highlight = {
          enable = true,                                                        -- set to 'true' to turn-on text highlighting
          disable = { },                                                        -- list of language that will be disabled, these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
          additional_vim_regex_highlighting = false,                            -- setting to the whole block this to true will run `:h syntax` and tree-sitter at the same time, set this to `true` if you depend on 'syntax' being enabled (like for indentation), using this option may slow down your editor, and you may see some duplicate highlights, instead of true it can also be a list of languages
        },
        ----NOTE / WARNING - these line comment out to workaround this bug - https://github.com/nvim-treesitter/nvim-treesitter/issues/1004
        --incremental_selection = {                                               -- using a single key for selection, treesetter help to define the region of code to selected
          --enable = true,
          --keymaps = {                                                           -- incrementally select block of text, set to `false` to disable one of the mappings
            --init_senection = "gnn",                                             -- initializes thew selection with the word under the cursor, original value was 'gnn)
            --node_incremental = "grn",                                           -- expand your selection of the node (e.g. whole line), do multiple time to widen selection, original value value 'grn
            --scope_incremental = "grc",                                          -- expand your selection to the scope (e.g. whole code block/scope), do multiple time to widen selection, original value value 'grc'
            --node_decremental = "grm",                                           -- un-expand your selection, original value value 'grc'
          --},
        --},
      })
    end,
  },

  -- provides to nvim-treesitter syntax aware of text-objects, giving you select, move, swap, and peek support
  --     [Understanding Neovim #5 - Textobjects, Incremental Selection](https://www.youtube.com/watch?v=ff0GYrK3nT0)
  --     [GitHub: nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false,
  },

  ---- Plugins for Code Comments and Documentation --------------------------------------------

  -- quick injection & removal of line comments or block comments
  --     [GitHub: numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
  --     [TakeTuesday E02: Comment.nvim](https://www.youtube.com/watch?v=-InmtHhk2qM)
  --     [neovimcraft: numToStr/Comment.nvim](https://neovimcraft.com/plugin/numToStr/Comment.nvim/index.html)
  { "numToStr/Comment.nvim", enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter", },
    opts = {
        -- add any options here to override the defaults
    },
  },


  ---- Auto-completion ------------------------------------------------------------------------

  --- install LSP first to see if these plugins are needed

  -- A completion plugin for neovim coded in Lua (useful for )
  --     [TakeTuesday E01: nvim-cmp](https://www.youtube.com/watch?v=_DnmphIwnjo)
  --     [GitHub: hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  { "hrsh7th/nvim-cmp", enabled = false,
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", },           -- these dependencies will only be loaded when cmp loads, dependencies are always lazy-loaded unless specified otherwise
    config = function()
      -- ...
    end,
  },


  ---- Formating and Reporting Tools ----------------------------------------------------------

  -- preview markdown files on your modern browser with synchronised scrolling and fast updates
  --     [GitHub: iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
  { "iamcco/markdown-preview.nvim", enabled = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

})

