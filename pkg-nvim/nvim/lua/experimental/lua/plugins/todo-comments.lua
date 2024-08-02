-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ Highlight, list, and search for referances to 'todo', 'fix' and other comments in your project.
kickstart2/lua/kickstart/plugins/todo-comment.lua

  Description:
    describe what this plugin does

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :TodoLocList             - shows you a list of all your ToDos, select will jump to it
      :TodoQuickFix            - shows you a list of all your ToDos, select will jump to it
      :TodoTelescope           - shows you a list of all your ToDos in Telescope
      :TodoTrouble             - list all project ToDos in trouble (folk/trouble.nvim)

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

    NOTE: To work properly, you must have a colon ':' character after the key word.
]]


-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    options                                                                     -- aka {opts}, keymap options
  )
end


return {
  'folke/todo-comments.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {                                                                      -- your configuration comes here or leave it empty to use the default settings
    signs = false,
    colors = {                                                                  -- list of named colors where we try to extract the guifg from the list of highlight groups or use the hex color if hl not found as a fallback
      error = { 'DiagnosticError', 'ErrorMsg', '#FF0000' },
      warning = { 'DiagnosticWarn', 'WarningMsg', '#FFFF00' },
      info = { 'DiagnosticInfo', '#008000' },
      hint = { 'DiagnosticHint', '#0000FF' },
      default = { 'Identifier', '#808080' },
      test = { 'Identifier', '#800080' },
    },
    keywords = {                                                                -- keywords recognized as todo comments
      FIX = {
        icon = ' ',                                                            -- icon used for the sign, and in search results
        color = 'error',                                                        -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'FIXIT', 'ISSUE', 'BUG' },                             -- a set of other keywords that all map to this FIX keywords
        -- signs = false,                                                       -- configure signs for some keywords individually
      },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', 'TIP' } },
      TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
  },
  config = function()
    local todo_comments = require("todo-comments")
    keymap("n", "]t", function() todo_comments.jump_next() end, { desc = "Next ToDo Comment" })
    keymap("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous ToDo Comment" })

    require('todo-comments').setup()
  end,
}

-- test cases
-- FIX: test case
-- TODO: test case
-- WARN: test case
-- HACK: test case
-- PERF: test case
-- NOTE: test case
-- TIP: test case
-- TEST: test case
-- FIXME: test case
-- INFO: test case
-- OPTIMIZE: test case

