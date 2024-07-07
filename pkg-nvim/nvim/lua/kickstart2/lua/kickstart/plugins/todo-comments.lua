--[[ Highlight, list, and search for referances to 'todo', 'fix' and other comments in your project.

    Usage:
        :TodoLocList    shows you a list of all your ToDos, select will jump to it
        :TodoQuickFix   shows you a list of all your ToDos, select will jump to it
        :TodoTelescope  shows you a list of all your ToDos in Telescope
        :TodoTrouble    List all project ToDos in trouble (folk/trouble.nvim)

    Sources:

    NOTE: You must have a colon ':' character after the key word. 
]]

--[[
return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
]]

--[[
return {
  'folke/todo-comments.nvim',
  event = { 'BufRead', 'VimEnter' },
  config = function()
    require('todo-comments').setup()
  end,
}
]]

return {
  'folke/todo-comments.nvim',
  enabled = true,
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { -- your configuration comes here or leave it empty to use the default settings
    signs = false,
    colors = { -- list of named colors where we try to extract the guifg from the list of highlight groups or use the hex color if hl not found as a fallback
      error = { 'DiagnosticError', 'ErrorMsg', '#FF0000' },
      warning = { 'DiagnosticWarn', 'WarningMsg', '#FFFF00' },
      info = { 'DiagnosticInfo', '#008000' },
      hint = { 'DiagnosticHint', '#0000FF' },
      default = { 'Identifier', '#808080' },
      test = { 'Identifier', '#800080' },
    },
    keywords = { -- keywords recognized as todo comments
      FIX = {
        icon = ' ', -- icon used for the sign, and in search results
        color = 'error', -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'FIXIT', 'ISSUE', 'BUG' }, -- a set of other keywords that all map to this FIX keywords
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

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
