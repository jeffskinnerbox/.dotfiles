
--------------------------------------------------------------------------------
-- editor-advanced/bufferline.lua

-- This is an attractive, informative, and easy to navigate tab-line function
-- which makes use of Nerd Foonts.

-- Sources:
--    [GitHub: akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
--    [Neovim - Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, "bufferline")
if not status_ok then
  print("'configs/bufferline.lua' module had an error")
  return
end


-- setup your plugin options & features
vim.opt.termguicolors = true
require("bufferline").setup{}

