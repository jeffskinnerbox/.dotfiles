-- luacheck: globals vim MyColorScheme
-- luacheck: max line length 300

--[[ Dark colorscheme inspired by famous painting of Katsushika Hokusai

  Description:

  Definitions:
    Themes
    Palette Colors
    Highlight Groups

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :colorscheme <name>                  - activate the <name> color scheme
      :e $VIMRUNTIME/colors                - takes you to color code for all the NeoVim built-in color schemes
      :so $VIMRUNTIME/syntax/hitest.vim    - see all the current active highlight groups
      :Telescope highlights                - see and search for the highlight groups
      :$VIMRUNTIME/syntax                  - see the syntax definitions and the highlight group definitions for all NeoVim natively supported languages

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
    [See 'The_Great_Wave_off_Kanagaw'](https://en.wikipedia.org/wiki/The_Great_Wave_off_Kanagawa)
]]


--[[

  Description:
    This is where you set the color scheme for the entire NeoVim envirnment.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :colorscheme <name>                  - activate the <name> color scheme
      :e $VIMRUNTIME/colors                - takes you to color code for all the NeoVim built-in color schemes
      :so $VIMRUNTIME/syntax/hitest.vim    - see all the current active highlight groups
      :Telescope highlights                - see and search for the highlight groups
      :$VIMRUNTIME/syntax                  - see the syntax definitions and the highlight group definitions for all NeoVim natively supported languages

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [Neovim for Beginners — Color Scheme](https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6)
    [Neovim - Colorschemes and how to set them](https://www.youtube.com/watch?v=RtNPfJKNr_8)
    [The BEST Neovim color themes; some with support for Terminals and the latest Lua](https://www.youtube.com/watch?v=_evGrg4l3C)
]]

-- global variables used to set neovim color scheme, recommended values are:
--     'kanagawa-dragon', 'kanagawa-wave', 'kanagawa-lotus'
--     'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon'
--     'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-macchiato', 'catppuccin-mocha'


return {
  'rebelot/kanagawa.nvim',                                                      -- load data for color schemefrom github
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = false,                                                                 -- 'false' means load at startup and 'true' means lazy-load this plugin and wait for an event to requires loading it, make sure that your main colorscheme is loaded first. To ensure this you can use the priority=1000 field
  priority = 1000,                                                              -- load the colorscheme before other non-lazy-loaded plugins
  config = function()                                                           -- configuration established (i.e. callback function is called) after color scheme plugin is installed
    require('kanagawa').setup {
      compile = false,                                                          -- set to 'true' to enable compiling the colorscheme
      undercurl = true,                                                         -- set to 'true' to enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,                                                      -- do not set background color
      dimInactive = true,                                                       -- set to 'true' to dim inactive window `:h hl-NormalNC`
      terminalColors = true,                                                    -- set to 'true' to define vim.g.terminal_color_{0,17}
--[[
      colors = {                                                                -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      --overrides = function(colors)                                            -- add/modify highlights
      --return {}
      --end,
]]--
      colors = {
        palette = {
          -- Background colors
          sumiInk0 = "#161616", -- modified
          sumiInk1 = "#181818", -- modified
          sumiInk2 = "#1a1a1a", -- modified
          sumiInk3 = "#1F1F1F", -- modified
          sumiInk4 = "#2A2A2A", -- modified
          sumiInk5 = "#363636", -- modified
          sumiInk6 = "#545454", -- modified

          -- Popup and Floats
          waveBlue1 = "#322C47", -- modified
          waveBlue2 = "#4c4464", -- modified

          -- Diff and Git
          winterGreen = "#2B3328",
          winterYellow = "#49443C",
          winterRed = "#43242B",
          winterBlue = "#252535",
          autumnGreen = "#76A56A", -- modified
          autumnRed = "#C34043",
          autumnYellow = "#DCA561",

          -- Diag
          samuraiRed = "#E82424",
          roninYellow = "#FF9E3B",
          waveAqua1 = "#7E9CD8", -- modified
          dragonBlue = "#7FB4CA", -- modified

          -- Foreground and Comments
          oldWhite = "#C8C093",
          fujiWhite = "#F9E7C0", -- modified
          fujiGray = "#727169",
          oniViolet = "#BFA3E6", -- modified
          oniViolet2 = "#BCACDB", -- modified
          crystalBlue = "#8CABFF", -- modified
          springViolet1 = "#938AA9",
          springViolet2 = "#9CABCA",
          springBlue = "#7FC4EF", -- modified
          waveAqua2 = "#77BBDD", -- modified

          springGreen = "#98BB6C",
          boatYellow1 = "#938056",
          boatYellow2 = "#C0A36E",
          carpYellow = "#FFEE99", -- modified

          sakuraPink = "#D27E99",
          waveRed = "#E46876",
          peachRed = "#FF5D62",
          surimiOrange = "#FFAA44", -- modified
          katanaGray = "#717C7C",
        },
      },
      theme = 'wave',                                                           -- Load "wave" theme when 'background' option is not set
      background = {                                                            -- map the value of 'background' option to a theme
        dark = 'wave',                                                          -- supported values are 'dragon', 'wave', 'lotus'
        light = 'lotus',
      },
    }
    local config = function(_, opts)
      require(MyColorScheme).setup(opts)                                        -- replace this with your favorite colorscheme
      vim.cmd.colorscheme(MyColorScheme)                                        -- replace this with your favorite colorscheme - select color scheme BUT setup() must be called before setting, find this in 'colorscheme.lua'

      -- Custom diff colors
      vim.cmd([[
        autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
        autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
        autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
        autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
      ]])

      -- Custom border colors
      vim.cmd([[
        autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
        autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
      ]])
    end
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}

