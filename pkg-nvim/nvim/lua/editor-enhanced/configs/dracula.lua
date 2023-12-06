
--------------------------------------------------------------------------------
-- editor-enhanced/dracula.lua

-- Dracula colorscheme for neovim written in Lua

-- Sources:
--   [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, nightfox = pcall(require, "dracula")
if not status_ok then
  print("'configs/dracula.lua' module had an error")
  return
end


-- setup will over-ride the plugin's default options & features
require('dracula').setup({
  --theme = "dracula-soft",
  theme = "dracula",
  colors = {               -- customize dracula color palette
    bg = "#202020",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  show_end_of_buffer = true,     -- show the '~' characters after the end of buffers, default false
  transparent_bg = false,         -- use transparent background, default false
  lualine_bg_color = "#44475a",  -- set custom lualine background color, default nil
  italic_comment = true,         -- set italic comment, default false
  overrides = {                  -- overrides the default highlights see `:h synIDattr`
    -- Examples
    -- NonText = { fg = dracula.colors().white },   -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {}                                 -- clear highlight of Nothing
  },
})

-- select color dracula, dracula-soft, etc., setup must be called before loading
--vim.cmd("colorscheme dracula-soft")
vim.cmd("colorscheme dracula")

