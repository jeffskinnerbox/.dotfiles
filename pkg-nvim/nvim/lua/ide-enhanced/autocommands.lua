
--------------------------------------------------------------------------------
-- ide-enhanced/autocommands.lua

-- You can specify commands to be executed automatically when reading or writing
-- a file, when entering or leaving a buffer or window, and when exiting NeoVim.

-- NOTE: Using autocommands is very powerful, and may lead to unexpected side
-- effects.  Be careful not to destroy your text.

-- Sources:
--    [How to remove Neovim trailing white space?](https://vi.stackexchange.com/questions/37421/how-to-remove-neovim-trailing-white-space)
--    [Restore screen size and position](http://vim.wikia.com/wiki/Restore_screen_size_and_position)
--    [Highlight trailing whitespaces in neovim](https://www.reddit.com/r/neovim/comments/chlmfk/highlight_trailing_whitespaces_in_neovim/)
--    [Neovim for Beginners —Lua Autocmd and Keymap Functions](https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42)
--------------------------------------------------------------------------------


-- SEE FOR MORE IDEAS HERE
-- https://github.com/harrisoncramer/nvim/blob/main/lua/autocommands.lua
-- [Vim: Creating parent directories on save](https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save)
-- [Modern Neovim — Configuration Hacks](https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f#7878)

--- highlight trailing whitespace with colored background
vim.cmd([[
" track which buffers have been created, and set the highlighting only once.
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1
highlight WhitespaceEOL ctermbg=red ctermfg=white guibg=#800000
autocmd WinEnter *
  \ if !exists('w:created') | call matchadd('WhitespaceEOL', '\s\+$') | endif
call matchadd('WhitespaceEOL', '\s\+$')
]])


-- delete trailing white space when you save the file
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = {'*'},
    callback = function()
        local save_cursor = vim.fn.getpos('.')       -- save original cursor position
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos('.', save_cursor)              -- restore cursor position
    end,
})


-- NOTE: - comment out because this causes highlighting of markdown files to stop and the file becomes write protected
-- set language-specific settings based on file type
--vim.cmd([[
  --autocmd FileType c,cpp,ino,h shiftwidth=4
  --autocmd FileType python,py shiftwidth=4
  --autocmd FileType markdown,md shiftwidth=2
  --autocmd FileType html setlocal shiftwidth=2
  --autocmd FileType php,html setlocal shiftwidth=2 expandtab
--]])

-- automatically reload neovim whenever you change & save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- when starting up neovim, expand the size of the terminal window for usability
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
    set columns=200                 " number of columns in the terminal window when Vim opens
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

