
--------------------------------------------------------------------------------
-- editor-advanced/toggleterm.lua

-- Toggleterm is a plugin that can create multiple terminals inside Neovim.
-- The main purpose I use it for quickly run a command or multiple commands
-- and then go right back to editing my file.

-- Sources:
--    [akinsho / toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
--    [Example Setup: toggleterm.lua](https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/toggleterm.lua)
--    [Neovim - Toggleterm | Open terminal programs in Neovim](https://www.youtube.com/watch?v=5OD-7h7gzxU)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  print("'configs/toggleterm.lua' module had an error")
  return
end


-- setup your plugin options & features
-- open terminal session with bash shell via command 'cntr+\'
toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],     -- open terminal with 'cntr+\'
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,       -- shade terminal window slightly darker
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",          -- terminal will be floating (instead of horizontal or vertical)
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

