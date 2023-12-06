
--------------------------------------------------------------------------------
-- editor-advanced/lualine.lua

-- Widely used Neovim statusline written in Lua. It's goal is to provide a easy
-- to customize and fast statusline.

-- Sources:
--   [GitHub: nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
--   [Lualine for Neovim](https://medium.com/@shaikzahid0713/lualine-for-neovim-776b79861699)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, "lualine")
if not status_ok then
  print("'configs/lualine.lua' module had an error")
  return
end


-- setup your plugin options & features
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',              -- should take colors from installed theme or set to 'dracula', 'material', 'tokyonight', 'tokyonight'
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

