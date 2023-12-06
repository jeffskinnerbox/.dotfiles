
--------------------------------------------------------------------------------
-- editor-enhanced/autocommands.lua

-- You can specify commands to be executed automatically when reading or writing
-- a file, when entering or leaving a buffer or window, and when exiting NeoVim.

-- WARNING: Using autocommands is very powerful, and may lead to unexpected side
-- effects.  Be careful not to destroy your text.

-- Sources
--    [How to remove Neovim trailing white space?](https://vi.stackexchange.com/questions/37421/how-to-remove-neovim-trailing-white-space)
--    [Restore screen size and position](http://vim.wikia.com/wiki/Restore_screen_size_and_position)
--------------------------------------------------------------------------------


 -- SEE FOR MORE IDEAS HERE
 -- https://github.com/harrisoncramer/nvim/blob/main/lua/autocommands.lua
 -- [Vim: Creating parent directories on save](https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save)
 -- [Modern Neovim — Configuration Hacks](https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f#7878)


-- delete trailing white space when you save the file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")             -- save original cursor position
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)              -- restore cursor position
    end,
})


-- automatically reload neovim whenever you change & save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- *************** THIS MAY HAVE CAUSED CORE DUMPS ***************
vim.cmd([[
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Vim Start-Up Size and Position
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To see or to set the current window position on the screen, you can use ':winpos'
" or ':winpos x y' but this will only work in the GUI (i.e. gvim).
" This is useful if you always want Vim to startup in the same location and
" size as the time you exit it (works for vim and gvim).
"
" http://vim.wikia.com/wiki/Restore_screen_size_and_position

" Function to increase the size of the terminal window for Vim editing
function! SizeUpFunc()
    if exists("g:oldColumns")
        return
    endif
    let g:oldColumns = &columns     " Save the current width
    let g:oldLines = &lines         " Save the current length
    "winpos 900 25	                " location of window when Vim opens, only works for gVim
    set lines=60                    " number of lines in  the terminal window when Vim opens
    set columns=160                 " number of columns in the terminal window when Vim opens
endfunction
command! SizeUp call SizeUpFunc()

" Function to restore the terminal window to its orginal size
function! SizeDownFunc()
    if !exists("g:oldColumns")
        return
    endif
    let &columns = g:oldColumns     " restore the orginal width
    let &lines = g:oldLines         " restore the orginal length
    unlet g:oldColumns              " remove the variable
    unlet g:oldLines                " remove the variable
endfunction
command! SizeDown call SizeDownFunc()

augroup VimStartUp
    " delete any old autocommands in this group
    autocmd!

    " save/restore the size of the terminal window
    autocmd VimEnter * SizeUp           " increase the size of the terminal window
    autocmd VimLeavePre * SizeDown      " restore terminal size when Vim quits

    " make Vim returns to the same line when we reopen a file
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

" remember info about open buffers on close
set viminfo^=%
]])

