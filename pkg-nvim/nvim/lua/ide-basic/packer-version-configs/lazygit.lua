
--------------------------------------------------------------------------------
-- ide-basic/lazygit.lua

-- This git user interface tool can add files easily, resolve merge conflicts,
-- checkout recent branches, view logs and diffs of branches, commits and stashes.
-- Plus quick push and pull, with squash and commit renaming, and interactive rebasing!

-- Lazygit Keybindings can be found [here](https://github.com/jesseduffield/lazygit/blob/master/docs/keybindings/Keybindings_en.md)

-- NOTE: The lazygit executable needs to be installed on the computer running NeoVim.

-- Sources:
--    [GitHub: jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)
--    [GitHub: kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
--    [Make advanced Git tasks simple with Lazygit](https://opensource.com/article/20/3/lazygit)
--    [Enhanced Productivity with This Terminal UI for Git Commands]https://bootcamp.uxdesign.cc/enhanced-productivity-with-this-terminal-ui-for-git-commands-ee7af02b63af
--    [lazygit deep dive: a productive terminal git UI](https://oliverguenther.de/2021/04/lazygit-an-introduction-series/)
--    [LazyGit: The Git Interface That Everyone Keeps Asking For](https://www.youtube.com/watch?v=uXv4poPOdvM)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rtn = pcall(require, "lazygit")
if not status_ok then
  print("'configs/lazygit.lua' module had an error")
  return
end


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example   keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be "n" = normal mode, "i" = insert mode, "v" = visual mode, "x" = visual block mode, "t" = term mode, "c" = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- keymap options
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local term_opts = { silent = true }


-- key mappings for markdown preview in modern browser
keymap('n', '<leader>lg', '<cmd>LazyGit<cr>', opts)       -- start a floating window with lazygit in the current working directory

