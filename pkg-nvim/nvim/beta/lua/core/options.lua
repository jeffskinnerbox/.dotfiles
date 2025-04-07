-- luacheck: globals vim
-- luacheck: max line length 300

--[[ Set NeoVim internal variables / switches to achieve special effects

  Description:
    NeoVim has a number of internal variables and switches which can be set to
    achieve special effects.  These options come in three forms: boolean,
    number, and string.

    Each option is set as either a global, buffer-scoped, or window-scoped
    (see ':help lua-options'). These are set with vim.o, vim.bo, and vim.wo
    respectively. If you're unsure what scope to use for a specific option
    ':help option-name' is your friend.

    A special interface (vim.opt) exists for conveniently interacting with list
    and map-style option from Lua. It allows accessing them as Lua tables and
    offers object-oriented method for adding and removing entries.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :help option-list        - list of all the options
      :help vim.opt            - lua interface to interacting with options

      :lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))       - current runtimepath
      :lua print(vim.opt.undodir)
      :lua print(vim.inspect(vim.opt.undodir))
      :lua print(vim.api.nvim_get_option('undodir'))

      :lua vim.api.nvim_echo({ { vim.inspect( some_long_object) } }, true, {})      - for printing debug statements   - https://neovim.discourse.group/t/how-to-print-a-string-with-many-lines-and-view-it-again-with-messages/2825

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [Everything you need to know to configure neovim using lua](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)
    [Vim documentation: options](https://vimdoc.sourceforge.net/htmldoc/options.html)
    [How to Configure Neovim](https://smarttech101.com/how-to-configure-neovim/)
    [options.lua](https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/options.lua)
    [Getting Started with Neovim](https://bryankegley.me/posts/nvim-getting-started/)
    [Neovim Setting basic options](https://www.chiarulli.me/Neovim-2/01-options/)
    [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
    [settings.lua](https://github.com/numToStr/dotfiles/blob/master/neovim/.config/nvim/lua/numToStr/settings.lua)
]]

-- alias the vim.opt meta-accessor to a local Lua variable
local o = vim.opt -- globally scoped editor variables
local g = vim.g -- globally scoped editor variables
local b = vim.bo -- buffer scoped
local w = vim.wo -- window scoped

-- neovim's default leader is ' ', but I prefer ','
-- leader affects all of vim, localleader is meant for a specific buffer, you generally use it based on a filetype. Using a localleader you can use the same leader-mapping for (slightly) different actions.
g.mapleader = "," -- ',' is your <leader> character
g.localleader = "\\" -- <leader> for mappings which are local to a buffer

-- initialization state of functionality
g.disable_autoformat = true -- initial state of 'format_on_save' in 'conform.lua'

-- spell checking
o.spell = false -- disable inline spell check at startup
o.spelllang = "en_us" -- use us english spelling dictionary
o.spellsuggest = "best,12" -- show 12 spell checking candidates at most
o.spellfile = "/home/jeff/.dotfiles/pkg-nvim/spell/en.utf-8.add" -- file used when you add words you don't want flagged by spell
-- o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"  -- file used when you add words you don't want flagged by spell

-- text searching
o.incsearch = true -- find the next search match as we type the search
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = true -- ignore case in search patterns
o.smartcase = true -- override the 'ignorecase' option if the search pattern contains upper case characters
o.gdefault = false -- if true, all matches in a line are substituted instead of just one

-- text search highlighting
--vim.cmd([[highlight Search guifg=Black guibg=Pink]])             -- when search succeeds, search string will be highlighted with pink background

-- line numbering
w.number = true -- set numbered lines
w.relativenumber = false -- set relative numbered lines
o.numberwidth = 4 -- set number column width (default 4)
vim.cmd([[highlight LineNr guifg=DarkGrey guibg=NONE]]) -- color highlight the line number

-- scrolling behavior
o.sidescroll = 1 -- minimal number of columns to scroll horizontally
o.scrolloff = 8 -- minimum lines of context
o.sidescrolloff = 8 -- minimal number of screen lines to keep above and below the cursor

-- file & string types
o.encoding = "utf8" -- string encoding to use
o.fileencoding = "utf-8" -- the encoding written to a file

-- default theme (will be over-written by plugins)
o.background = "dark" -- set the global variable background to dark mode (default is dark)
o.syntax = "off" -- enable nvim native syntax highlighting - set nvim native syntax highlighting to 'off' (vim.opt.syntax = 'off') when using treesitter
o.termguicolors = true -- set term gui colors (most terminals support this)
w.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.background = "dark" -- when set to "dark" or "light", adjusts the default color groups for that background type
o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.colorcolumn = "80" -- color column to show my preferred maximum line length of text & code
vim.cmd([[highlight colorcolumn guibg=black]]) -- color of the color column, using 'black' for a subtle contrast of the background color

-- whitespace, tabs, indents
o.tabstop = 2 -- insert 2 spaces for a tab
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.softtabstop = 2 -- number of spaces tabs count for in insert mode
o.expandtab = true -- convert tabs to spaces
b.autoindent = true -- copy indent from current line when starting a new line
o.shiftround = true -- round indent to multiple of 'shiftwidth'. applies to > and < commands. CTRL-T and CTRL-D in Insert mode always round the indent to a multiple of 'shiftwidth'
b.smartindent = true -- do smart auto-indenting when starting a new line
b.copyindent = true -- copy previous indent on enter

-- tab-page
--vim.cmd([[highlight TabLineFill ctermfg=black ctermbg=gray]])
--vim.cmd([[highlight TabLine ctermfg=black ctermbg=gray]])
--vim.cmd([[highlight TabLineSel ctermfg=darkgreen ctermbg=gray]])

-- screen splits
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window

-- commandline / cursorline color & shape & movement
o.showmode = false -- do not show current mode on the last line
o.cmdheight = 2 -- more space in the neovim command line for displaying messages (default 1)
o.cursorline = true -- highlight the current cursor line
o.cursorcolumn = true -- highlight the current cursor column
vim.cmd([[highlight cursorline guibg=black]]) -- color of the cursor line
vim.cmd([[highlight cursorcolumn guibg=black]]) -- color of the cursor column
--o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"      -- set cursor (default "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")
o.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.cmd([[set whichwrap+=<,>,[,],h,l]]) -- allows left/right cursor moves to move to the previous/next line when the cursor is on the first/last character in the line
o.magic = true -- for regular expressions turn magic on
o.showcmd = true -- show (partial) commands in status line
o.ruler = true -- show the line and column number of the cursor position, separated by a comma.

-- window title
o.title = true -- set the title of window to the value of the titlestring
o.titlestring = "%<%F%=%l/%L - NeoVim" -- what the title of the window will be set to

-- bracket matching
o.showmatch = true -- show matching brackets when text indicator is over them
o.mat = 2 -- tenths of a second to blink when matching brackets

-- copy & paste / clipboard
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- undo & history
o.history = 50 -- remember 50 items in commandline history
o.undofile = true -- enable persistent undo
--o.undodir = vim.fn.stdpath('config') .. '/undo'                -- directory names for undo file

-- backup & swap                                                 -- disable backup and swap files (they trigger too many events)
b.swapfile = false -- use a swapfile for the buffer
--o.directory = vim.fn.stdpath('config') .. '/swap'              -- directory names for the swap file, separated with commas
o.backup = false -- do not creates a backup file while editing
o.writebackup = false -- make a backup before overwriting a file, then backup is removed, unless the 'backup' option is also on
--o.backupdir = vim.fn.stdpath('config') .. '/backup'            -- directory names for backup files, separated with commas

o.autoread = false -- when a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again. when the file has been deleted this is not done, so you have the text from before it was deleted.
o.lazyredraw = false -- the screen will not be redrawn while executing macros - NOTE: this is only meant to be set temporarily and if you enable 'lazyredraw', you'll experience issues using `Noice` (see `:h 'lazyredraw'`)

-- file name tab-line labels
o.showtabline = 2 -- always show lines between tab-page labels

-- text wraping, fonts
w.wrap = false -- display lines as one long line and don't wrap around at end of terminal
b.wrapmargin = 4 -- number of characters from right window border when wrapping starts
o.breakindent = true -- when wrap enabled, preserve the indentation of a virtual line

-- line folding (default, this could be overridden by treesitter, etc. plugins)
o.foldmethod = "expr" -- treesitter enabled folding
o.foldexpr = "nvim_treesitter#foldexpr()" -- treesitter enabled folding
o.foldmethod = "indent" -- lines with equal indent form a fold
o.foldlevelstart = 99 -- start editing with all folds closed (value 0), some folds closed (1) or no folds closed (99)
o.foldnestmax = 3 -- maximum nesting of folds for the 'indent' and 'syntax' methods (default 20)
o.foldminlines = 1 -- number of screen lines above which a fold can be displayed closed (default 1)
o.foldcolumn = "auto:3" -- add a bit extra margin to the left when folding (default "0")

-- sets how neovim will display certain whitespace characters in the editor. See `:help 'list'` and `:help 'listchars'`
o.list = false
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- mouse usage
o.mouse = "a" -- enable mouse usage to paste, etc, 'a' = all modes, 'nv' - normal & visual modes, press shift while selecting with the mouse

-- error handling
o.errorbells = true -- ring the bell (beep or screen flash) for error messages (default is false)
o.visualbell = true -- see a brief window flash on error
o.shortmess:append("c") -- don't display ins-completion-menu messages

-- vim modeline feature
o.modeline = false -- if false, modeline feature will be disabled
o.modelines = 5 -- gives the number of lines that are checked, default value is 5, if modeline is off or 'modelines' is zero no lines are checked

-- command-line completion
o.wildmenu = true -- when 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.wildmode = { "list", "longest" } -- command-line completion mode

-- other options
o.completeopt = "menuone,noinsert,noselect" -- comma-separated list of options for Insert mode completion
o.conceallevel = 0 -- so that `` is visible in markdown files
o.hidden = true -- required to keep multiple buffers and open multiple buffers
o.pumheight = 10 -- pop up menu height
o.timeout = true
o.timeoutlen = 300 -- time to wait for a mapped sequence to complete, in milliseconds (default 1000)
o.updatetime = 250 -- faster completion (default 4000ms)
o.inccommand = "split" -- when nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
g.python3_host_prog = "/usr/bin/python3" -- command to start python3, this makes startup faster
