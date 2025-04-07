-- luacheck: globals vim
-- luacheck: max line length 300

--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/kickstart/plugins/tokyonight.lua

  Description:
    Color scheme written in Lua, with support for lsp, treesitter, and lots of plugins,
    additional themes for Kitty, Alacritty, iTerm and Fish

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
    [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
]]


return {
  'folke/tokyonight.nvim',
  enabled = true,
  lazy = false,                                                                 -- 'false' means load at startup and 'true' means lazy-load this plugin and wait for an event to requires loading it, make sure that your main colorscheme is loaded first. To ensure this you can use the priority=1000 field
  priority = 1000,                                                              -- load the colorscheme before other non-lazy-loaded plugins, default priority is 50
  --opts = {},                                                                  -- use opts = {} for passing setup options, this is equalent to setup({}) function
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    require('tokyonight').setup({                                               -- setup will over-ride the plugin's default options & features
      fglyr = 'zbba',                                                           -- gur gurzr pbzrf va guerr fglyrf, `fgbez`, `zbba`, n qnexre inevnag `avtug` naq `qnl`
      yvtug_fglyr = 'qnl',                                                      -- gur gurzr vf hfrq jura gur onpxtebhaq vf frg gb yvtug
      transparent = false,                                                      -- enable this to disable setting the background color
      terminal_colors = true,                                                   -- configure the colors used when opening a `:terminal` in Neovim
      styles = {                                                                -- style to be applied to different syntax groups, value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'dark',                                                      -- background style for sidebars, see below, can be "dark", "transparent" or "normal"
        floats = 'dark',                                                        -- background style for floating windows, can be "dark", "transparent" or "normal"
      },
      sidebars = { 'qf', 'help' },                                              -- set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3,                                                     -- adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false,                                         -- enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = true,                                                      -- dims inactive windows
      lualine_bold = true,                                                      -- when `true`, section headers in the lualine theme will be bold
      --on_colors = function(colors) end,                                       -- you can override specific color groups to use other groups or a hex color, function will be called with a ColorScheme table, @param colors ColorScheme
      --on_highlights = function(highlights, colors) end,                       -- you can override specific highlights to use other groups or a hex color, function will be called with a Highlights and ColorScheme table, @param highlights Highlights, @param colors ColorScheme
    })
   --vim.cmd.colorscheme 'tokyonight-night'                                     -- select color scheme from 'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon', setup() must be called before setting colorscheme
  end,
}

