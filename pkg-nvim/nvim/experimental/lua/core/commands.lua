-- luacheck: globals vim
-- luacheck: max line length 300


--[[
-- toggle on/off tabs and trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<cr>


--  Hidden Text
-- toggle between showing and hiding hidden characters
nmap <leader>hc :set list!<cr>

--" enumerates which hidden characters to display and which character to display them with
set listchars=tab:>-,trail:.,extends:#,nbsp:.


-- color the tabs
highlight TabLineFill ctermfg=Black ctermbg=Gray
highlight TabLine ctermfg=Black ctermbg=Gray
highlight TabLineSel ctermfg=DarkGreen ctermbg=Gray
]]--

