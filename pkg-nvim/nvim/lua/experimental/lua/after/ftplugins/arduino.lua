-- luacheck: globals vim
-- luacheck: max line length 300


-- set whitespace, tabs, indents
vim.opt_local.tabstop = 4                                  -- insert this number of spaces for a tab
vim.opt_local.shiftwidth = 4                               -- the number of spaces inserted for each additional indentation
vim.opt_local.softtabstop = 4                              -- number of spaces tabs count for in insert mode
vim.opt_local.expandtab = true                             -- convert tabs to spaces
vim.opt_local.autoindent = true                            -- copy indent from current line when starting a new line
vim.opt_local.shiftround = true                            -- round indent to multiple of 'shiftwidth'. applies to > and < commands. CTRL-T and CTRL-D in Insert mode always round the indent to a multiple of 'shiftwidth'
vim.opt_local.smartindent = true                           -- do smart autoindenting when starting a new line
vim.opt_local.copyindent = true                            -- copy previous indent on enter

