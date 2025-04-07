
--------------------------------------------------------------------------------
-- editor-enhanced/tokyonight.lua

-- Sources:
--   [GitHub: folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
--   [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
--   [12 Neovim Themes with Tree-sitter Support](https://alpha2phi.medium.com/12-neovim-themes-with-tree-sitter-support-8be320b683a4)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, nightfox = pcall(require, "tokyonight")
if not status_ok then
  print("'configs/tokyonight.lua' module had an error")
  return
end


-- setup will over-ride the plugin's default options & features
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day",    -- The theme is used when the background is set to light
  transparent = false,    -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark",    -- style for sidebars, see below
    floats = "dark",      -- style for floating windows
  },
  sidebars = { "qf", "help" },        -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3,               -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false,   -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false,               -- dims inactive windows
  lualine_bold = false,               -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

-- select color scheme from 'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon'
vim.cmd("colorscheme tokyonight-night")
--vim.cmd("colorscheme tokyonight-storm")
--vim.cmd("colorscheme tokyonight-day")
--vim.cmd("colorscheme tokyonight-moon")

