
--[[----------------------------------------------------------------------------
editor-enhanced/autocommands.lua

You can specify commands to be executed automatically when reading or writing
a file, when entering or leaving a buffer or window, and when exiting NeoVim.

WARNING: Using autocommands is very powerful, and may lead to unexpected side
effects.  Be careful not to destroy your text.

Sources
    [How to remove Neovim trailing white space?](https://vi.stackexchange.com/questions/37421/how-to-remove-neovim-trailing-white-space)
    [Restore screen size and position](http://vim.wikia.com/wiki/Restore_screen_size_and_position)

 For More Ideas
    https://github.com/harrisoncramer/nvim/blob/main/lua/autocommands.lua
    [Vim: Creating parent directories on save](https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save)
    [Modern Neovim — Configuration Hacks](https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f#7878)
----------------------------------------------------------------------------]]--


-- delete trailing white space when you save the file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")                                        -- save original cursor position
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)                                         -- restore cursor position
    end,
})

-- highlight yanked text on e.g. yy,yap etc.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("weeheavy-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

