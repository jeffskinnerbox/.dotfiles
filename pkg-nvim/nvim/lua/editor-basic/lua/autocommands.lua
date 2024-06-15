
--[[----------------------------------------------------------------------------
editor-basic/autocommands.lua

You can specify commands to be executed automatically when reading or writing
a file, when entering or leaving a buffer or window, and when exiting NeoVim.

WARNING: Using auto-commands is very powerful, and may lead to unexpected side
effects.  Be careful not to destroy your text.

Sources
      [How to remove Neovim trailing white space?](https://vi.stackexchange.com/questions/37421/how-to-remove-neovim-trailing-white-space)
      [Restore screen size and position](http://vim.wikia.com/wiki/Restore_screen_size_and_position)
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

