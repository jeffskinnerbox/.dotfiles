
--------------------------------------------------------------------------------
-- ide-basic/gitsigns.lua

-- The 'gitsigns.mvim' plugin adds decorations and status for you git controlled files.
-- The plugin also provides functional usage, enabling almost any Git operation,
-- but mainly using it for its aesthetic and status.

-- Sources:
--    [GitHub: lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
--    [Neovim - Gitsigns Powerful Git Plugin for Neovim](https://www.youtube.com/watch?v=ZgyVY7tArwg)
--    [Git-Integration In Neovim](https://medium.com/@shaikzahid0713/git-integration-in-neovim-a6f26c424b58)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rtn = pcall(require, "gitsigns")
if not status_ok then
  print("'configs/gitsigns.lua' module had an error")
  return
end


require("gitsigns").setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "🔺", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "🔺", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "┆", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true,                    -- toggle with `:Gitsigns toggle_signs`
  numhl = false,                        -- toggle with `:Gitsigns toggle_numhl`
  linehl = false,                       -- toggle with `:Gitsigns toggle_linehl`
  word_diff = false,                    -- toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,           -- toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",              -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,               -- use default
  max_file_length = 40000,
  preview_config = {                    -- options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}

