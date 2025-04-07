
--------------------------------------------------------------------------------
-- editor-enhanced/nightfox.lua

-- NightFox is a customizable theme for vim & neovim with support for
-- lsp, treesitter and a variety of plugins.

-- Sources:
--   [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
--   [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
  print("'configs/nightfox.lua' module had an error")
  return
end


-- setup will over-ride the plugin's default options & features
nightfox.setup {
  palettes = {
    -- custom nightfox with black background
    nightfox = {
      bg1 = "#1A120B",      -- standard background
      bg0 = "#1d1d2b",      -- Alt backgrounds (floats, statusline, etc.)
      bg3 = "#121820",      -- 55% darkened from stock
      sel0 = "#131b24",     -- 55% darkened from stock
    },
  },
  specs = {
    all = {
      inactive = "bg0",     -- Default value for other styles
    },
    nightfox = {
      inactive = "#090909", -- Slightly lighter then black background
    },
  },
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
}

require('nightfox').compile()       -- lua api version
vim.cmd("colorscheme nightfox")     -- select color scheme, nightfox, dayfox, duskfox, etc., setup must be called before loading

-- lightline checks the value of 'vim.g.lightline.colorscheme'
-- it does not depend on the value of the ':colorscheme' command, so you must set it
vim.g.lightline = { colorscheme = "nightfox" }

