
--------------------------------------------------------------------------------
-- editor-enhanced/lualine.lua

-- Sources:
--   []()
--   []()
--   []()
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, "lualine")
if not status_ok then
  print("'configs/lualine.lua' module had an error")
  return
end


-- setup your plugin options & features
require('lualine').setup {
  options = { theme = 'auto' }  -- should take colors from installed theme or set to 'dracula', 'material', 'tokyonight', 'tokyonight'
}

