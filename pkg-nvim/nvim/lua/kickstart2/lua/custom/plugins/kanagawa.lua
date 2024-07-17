-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ Dark colorscheme inspired by famous painting of Katsushika Hokusai
kickstart2/lua/custom/plugins/kanagawa.lua

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


return {
  'rebelot/kanagawa.nvim',                                                      -- load data for color schemefrom github
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = false,                                                                 -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
  config = function()                                                           -- configuration established (i.e. callback function is called) after color scheme plugin is installed
    require('kanagawa').setup {
      compile = false,                                                          -- enable compiling the colorscheme
      undercurl = true,                                                         -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,                                                      -- do not set background color
      dimInactive = true,                                                       -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,                                                    -- define vim.g.terminal_color_{0,17}
      colors = {                                                                -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      --overrides = function(colors)                                            -- add/modify highlights
      --return {}
      --end,
      theme = 'wave',                                                           -- Load "wave" theme when 'background' option is not set
      background = {                                                            -- map the value of 'background' option to a theme
        dark = 'wave',                                                          -- supported values are 'dragon', 'wave', 'lotus'
        light = 'lotus',
      },
    }
    --vim.cmd.colorscheme('kanagawa-dragon')                                    -- select color scheme BUT setup() must be called before setting, find this in 'colorscheme.lua'
  end,
}

