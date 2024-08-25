-- luacheck: globals vim
-- luacheck: max line length 300


--[[
--See: https://neovim.io/doc/user/lua.html#vim.filetype.add%28%29
vim.filetype.add({
	extension = {
	},
	filename = {
		[".bash_login"] = "sh",
		[".bash_logout"] = "sh",
		["bash_aliases"] = "sh",
		["bash_colors"] = "sh",
		["bash_prompt"] = "sh",
	},
})
--]]

--[[
-- See: https://www.reddit.com/r/neovim/comments/12qzsu1/changing_a_filetype_on_open/ and https://git.freiewildbahn.de/oli/nvim/src/commit/8b373ff24f38b540c9d9ec7d4996359f89b68b62/lua/my_autocommands.lua
local fileGrp = vim.api.nvim_create_augroup('file_type', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '.bash_*', 'bash_*' },
  callback = function()
    vim.bo.filetype = 'sh'
  end,
  group = fileGrp,
})
]]--


-- set whitespace, tabs, indents
vim.opt_local.tabstop = 4                                  -- insert this number of spaces for a tab
vim.opt_local.shiftwidth = 4                               -- the number of spaces inserted for each additional indentation
vim.opt_local.softtabstop = 4                              -- number of spaces tabs count for in insert mode
vim.opt_local.expandtab = true                             -- convert tabs to spaces
vim.opt_local.autoindent = true                            -- copy indent from current line when starting a new line
vim.opt_local.shiftround = true                            -- round indent to multiple of 'shiftwidth'. applies to > and < commands. CTRL-T and CTRL-D in Insert mode always round the indent to a multiple of 'shiftwidth'
vim.opt_local.smartindent = true                           -- do smart autoindenting when starting a new line
vim.opt_local.copyindent = true                            -- copy previous indent on enter

