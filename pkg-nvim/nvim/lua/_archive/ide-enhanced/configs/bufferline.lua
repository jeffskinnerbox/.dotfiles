
--------------------------------------------------------------------------------
-- active/bufferline.lua

-- This is an attractive, informative, highly configurable and easy to navigate
-- tab-line function which makes use of Nerd Fonts.

-- To move between buffers, use
--    <tab>                            - move to the next buffer
--    <shift>+<tab>                    - move to the previous buffer

-- For more details on how to configure this plugin, see

--    :help bufferline-configuration   - see all configuration options
--    :help bufferline-styling         - change the appearance of the bufferline separators

-- Sources:
--    [GitHub: akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
--    [Neovim - Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)
--    [Installing lualine.nvim and bufferline.nvim - Neovim Lua From Scratch #3](https://www.youtube.com/watch?v=quPUdKBYScY)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, 'bufferline')
if not status_ok then
  print("'configs/bufferline.lua' module had an error")
  return
end


-- you need to be using termguicolors for this plugin to work, as it reads the hex gui color values of various highlight groups.
vim.opt.termguicolors = true

-- setup your plugin options & features
local bufferline = require('bufferline')
require('bufferline').setup {
  options = {
    style_preset = bufferline.style_preset.default,
    separator_style = 'slant',     -- seperator between tabs is slanted
    diagnostics = 'nvim_lsp',      -- you will get an indicator in the bufferline, for a given tab if it has any errors
  },
}

