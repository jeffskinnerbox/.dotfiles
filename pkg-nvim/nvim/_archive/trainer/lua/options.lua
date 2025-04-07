
-- NOTE: this is my default Vim options file but with options not suitable for this context, I have commented out

-- alias for your options & variables within the buffers, tabs, windows, and global scope
local g = vim.g                                                  -- option with globally scoped
local o = vim.opt                                                -- option with globally and local scoped
local b = vim.bo                                                 -- option with buffer only scoped
local w = vim.wo                                                 -- option with window only scoped
local t = vim.to                                                 -- option with tab only scoped

-- if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised)
--o.loaded_netrw = 1                                               -- disable netrw entirely
--o.loaded_netrwPlugin = 1                                         -- disable netrw entirely

-- mapleader has to be set before starts loading any of the plugins, neovim's default leader is ' ', but I prefer ','
g.mapleader = ","                                                -- ',' is your <leader> character
g.localleader = "\\"                                             -- <leader> for mappings which are local to a buffer

-- spell checking
--o.spell = false                                                  -- disable inline spell check at startup
--o.spelllang = "en_us"                                            -- use us english spelling dictionary
--o.spellsuggest = "best,12"                                       -- show 12 spell checking candidates at most
--o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"  -- file used when you add words you don't want flagged by spell

-- text searching
--o.incsearch = true                                               -- find the next search match as we type the search
--o.hlsearch = true                                                -- highlight all matches on previous search pattern
o.ignorecase = true                                              -- ignore case in search patterns, in neovim commands, etc.
--o.smartcase = true                                               -- override the 'ignorecase' option if the search pattern contains upper case characters
--o.gdefault = false                                               -- if true, all matches in a line are substituted instead of just one

-- text search highlighting
--vim.cmd([[highlight Search guifg=Black guibg=Pink]])             -- when search succeeds, search string will be highlighted with pink background

-- line numbering
o.number = true                                                  -- set numbered lines
o.relativenumber = true                                          -- set relative numbered lines
--o.numberwidth = 4                                                -- set number column width (default 4)
--vim.cmd([[highlight LineNr guifg=DarkGrey guibg=NONE]])          -- color highlight the line number

-- scrolling behavior
--o.sidescroll = 1                                                 -- minimal number of columns to scroll horizontally
o.scrolloff = 8                                                  -- minimum lines of context, set to 999 to keep the cursor centered
--o.sidescrolloff = 8                                              -- minimal number of screen lines to keep above and below the cursor

-- file & string types
--o.encoding = "utf8"                                              -- string encoding to use
--o.fileencoding = "utf-8"                                         -- the encoding written to a file

-- default theme (will be over-written by plugins)
--o.syntax = "off"                                                 -- enable nvim native syntax highlighting - set nvim native syntax highlighting to 'off' (vim.opt.syntax = 'off') when using treesitter
o.termguicolors = true                                           -- set term gui colors (most terminals support this) to enable highlighting
--w.signcolumn = "yes"                                             -- always show the sign column, otherwise it would shift the text each time
--o.background = "dark"                                            -- when set to "dark" or "light", adjusts the default color groups for that background type
--o.guifont = "monospace:h17"                                      -- the font used in graphical neovim applications
--o.colorcolumn = "80"                                             -- color column to show maximum line length
--vim.cmd([[highlight colorcolumn guibg=black]])                   -- color of the color column

-- whitespace, tabs, indents
o.tabstop = 4                                                    -- insert this many spaces for a tab when saving a file
o.expandtab = true                                               -- convert tabs to spaces
o.shiftwidth = 4                                                 -- the number of spaces inserted for each indentation
--o.softtabstop = 2                                                -- number of spaces tabs count for in insert mode
--b.autoindent = true                                              -- copy indent from current line when starting a new line
--o.shiftround = true                                              -- round indent to multiple of 'shiftwidth'. applies to > and < commands. CTRL-T and CTRL-D in Insert mode always round the indent to a multiple of 'shiftwidth'
--b.smartindent = true                                             -- do smart auto-indenting when starting a new line
--b.copyindent = true                                              -- copy previous indent on enter

-- screen splits
o.splitbelow = true                                              -- force all horizontal splits to go below current window
o.splitright = true                                              -- force all vertical splits to go to the right of current window

-- commandline / cursorline color & shape & movement
--o.showmode = false                                               -- do not show current mode on the last line
--o.cmdheight = 2                                                  -- more space in the neovim command line for displaying messages (default 1)
--o.cursorline = true                                              -- highlight the current cursor line
--o.cursorcolumn = true                                            -- highlight the current cursor column
--vim.cmd([[highlight cursorline guibg=black]])                    -- color of the cursor line
--vim.cmd([[highlight cursorcolumn guibg=black]])                  -- color of the cursor column
--o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
--vim.cmd([[set whichwrap+=<,>,[,],h,l]])                          -- allows left/right cursor moves to move to the previous/next line when the cursor is on the first/last character in the line
--o.magic = true                                                   -- for regular expressions turn magic on
--o.showcmd = true            		                               -- show (partial) commands in status line
--o.ruler = true                                                   -- show the line and column number of the cursor position, separated by a comma.

-- window title (will be over-written by alacritty terminal)
--o.title = true                                                   -- set the title of window to the value of the 'titlestring'
--o.titlestring = "%<%F%=%l/%L - NeoVim - trainer"                 -- what the title of the window will be set to

-- bracket matching (will be over-written by plugins)
--o.showmatch = true		                                         -- show matching brackets when text indicator is over them
--o.mat = 2                                                          -- tenths of a second to blink when matching brackets

-- copy & paste / clipboard
o.clipboard = "unnamedplus"                                      -- allows neovim to access the system clipboard

-- undo & history
--o.history = 50                                                   -- remember 50 items in commandline history
--o.undofile = true                                                -- enable persistent undo
--o.undodir = vim.fn.stdpath('config') .. '/undo'                  -- directory names for undo file

-- backup & swap
--b.swapfile = false                                               -- disable backup and swap files (they trigger too many events)
--o.directory = vim.fn.stdpath('config') .. '/swap'                -- directory names for the swap file, separated with commas
--o.backup = false                                                 -- do not creates a backup file while editing
--o.writebackup = false                                            -- make a backup before overwriting a file, then backup is removed, unless the 'backup' option is also on
--o.backupdir = vim.fn.stdpath('config') .. '/backup'              -- directory names for backup files, separated with commas

--o.autoread = false                                               -- when a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again. when the file has been deleted this is not done, so you have the text from before it was deleted.
--o.lazyredraw = true                                              -- the screen will not be redrawn while executing macros, registers and other commands that have not been typed.  also, updating the window title is postponed.

-- file name tab-line labels
--o.showtabline = 2                                                -- always show lines between tab-page labels

-- text wraping, fonts
w.wrap = false                                                   -- display lines as one long line and don't wrap around at end of terminal
--b.wrapmargin = 4	                                               -- number of characters from right window border when wrapping starts
--o.breakindent = true                                             -- when wrap enabled, preserve the indentation of a virtual line

-- line folding (default, this could be overridden by treesitter, etc. plugins)
--o.foldmethod = 'indent'                                          -- lines with equal indent form a fold
--o.foldlevelstart = 99                                            -- start editing with all folds closed (value 0), some folds closed (1) or no folds closed (99)
--o.foldnestmax = 3                                                -- maximum nesting of folds for the 'indent' and 'syntax' methods (default 20)
--o.foldminlines = 1                                               -- number of screen lines above which a fold can be displayed closed (default 1)
--o.foldcolumn = "auto:3"                                          -- add a bit extra margin to the left when folding (default "0")

-- mouse usage
--o.mouse = "a"                                                    -- enable mouse usage; to paste, press shift while selecting with the mouse

-- error handling
--o.errorbells = true                                              -- ring the bell (beep or screen flash) for error messages (default is false)
--o.visualbell = true                                              -- see a brief window flash on error
--o.shortmess:append "c"                                           -- don't display ins-completion-menu messages

-- other options
o.virtualedit = "block"                                          -- eliminates some problems with Visual Block mode
--o.completeopt = "menuone,noinsert,noselect"                      -- comma-separated list of options for Insert mode completion
--o.conceallevel = 0                                               -- so that `` is visible in markdown files
--o.hidden = true                                                  -- required to keep multiple buffers and open multiple buffers
--o.pumheight = 10                                                 -- pop up menu height
--o.timeoutlen = 1000                                              -- time to wait for a mapped sequence to complete, in milliseconds (default 1000)
--o.updatetime = 500                                               -- faster completion (default 4000ms)
--o.wildmenu = true                                                -- when 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.inccommand = "split"                                           -- when 'split', shows the effects of commands like '%s/X/Y/' in a split window at the bottom
--o.python3_host_prog = '/usr/bin/python3'                         -- command to start python3, this makes startup faster

