-- luacheck: globals vim
-- luacheck: max line length 300

--[[ maps key combinations to change the meaning of typed keys
kickstart2/lua/keymaps.lua

    Description:
      This file maps key combinations to change the meaning of typed keys. Typically
      this would be to perfromal an editoral operation or execute a function.

    As outlined in the 'whick-key.lua' plugin, I'm organizing my key mappings
    in these large 'key' buckets:

          Movements                  - ]<> [<>
          Buffer Mgmt.               - <leader>a
          Buffer Mgmt.               - <leader>b
          Window Split Mgmt.         - <leader>s
          Jump to Location/File      - <leader>j
          Tab Management             - <leader>t
          Toggle Feature On/Off      - <leader>T
          Format/Lint/Debug Code     - <leader>c     FIX: needs to be updated
          Documentation/Definitions  - <leader>d
          Filesystem Explorer        - <leader>e
          Error/Diagnostic/Troubles  - <leader>E
          Git Operations             - <leader>g
          Workspace/Session Mgmt.    - <leader>w

  Definitions:
          Buffer - A buffer is the in-memory text of a file. Use buffers to open
                   up all required files to get current task done.
          Window - A window is a viewport on a buffer. In Vim, you can have multiple
                   windows opened. Use windows when you need to view multiple buffers.
          Tab    - A tab page is a collection of windows. In Vim, a tab does not
                   represent an open file. Use tabs when working on different projects.
                   Like one tab for server codes and one tab for client codes.

    Usage:
      To view all of the keys maps for the current buffer by all of plugins, modules, etc,
      use the `nmap` command:

        Commandline:
          :nmap                 - for list of normal mode mappings
          :imap                 - for list of insert mode mappings
          :xmap                 - for list of visual mode mappings
          :vmap                 - for list of visual & select mode mappings
          :smap                 - for list of select mode mappings
          :cmap                 - for list of command-line mode mappings
          :omap                 - for list of operator-pending mode mappings
          :help map             - for a complete list of all mappings
          :Telescope keymaps    - for a complete list of all mappings viewable with fuzzy search

       Enter ':help map' for a complete list. If you're using Telescope, then you can
       use ':Telescope keymaps' to view/fuzzy search them.

    Sources:
        [My approach to Neovim](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625)
        [Setting Key Mappings](https://tui.ninja/neovim/customizing/keymaps/setting/)
        [Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/)
        [Configure Nvim with Lua: Keymaps (2)](https://manujsdev.com/blog/config-nvim-with-lua-keymaps)
        [Mapping keys in Vim - Tutorial](https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1))
        [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
        [Install and Set Up Which Key in Neovim/Nvim And Never Forget Your Key Mappings](https://linovox.com/install-and-set-up-which-key-in-neovim-nvim/)
        [Which-Key for Neovim](https://medium.com/@shaikzahid0713/which-key-7554ac347c9d)
        [which-key.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=hB-k7VOCONs)
        [Using buffers, windows, and tabs efficiently in Vim](https://dev.to/iggredible/using-buffers-windows-and-tabs-efficiently-in-vim-56jc)
        [Cheatsheet for Buffers, Windows and Tabs of Vim](https://feici02.github.io/2017/05/28/buffers-windows-tabs.html)
]]


-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    options                                                                     -- aka {opts}, keymap options
  )
end


-- [[ Normal Mode ]] -----------------------------------------------------------
-- a neutral state, waiting for user to input something

-- Movements - ]<> [<> ------------------------------------------
--[[ TODO THIS - [The Underrated Square Bracket (NeoVim Conf 2023)](https://www.joshmedeski.com/posts/underrated-square-bracket/)
          Referances
            \]\] --> move forward to the next reference under your cursor
            \[\[ --> move backward to the next reference under your cursor
          Buffers
            ]b --> forward to next buffers
            [b --> backward to previous buffers
          Git Hunks
            ]g --> forward next git hunk
            [g --> backward next git hunk
          LSP Diagnostics / Errors / Warnings
            ]d --> forward to next diagnostic
            [d --> backward to next diagnostic
            ]e --> forward to next error
            [e --> backward to next error
            ]w --> forward to next warning
            [w --> backward to next warning
          TODO Comments
            ]t --> forward to next TODO item
            [t --> backward to next TODO item
          Treesitter
            ]c --> jump to the parent of a class
            [c --> jump to the parent of a class
            [f --> jump to a function
            ]f --> jump to a function
--]]

-- turn-off search term highlighting
vim.opt.hlsearch = true -- turn on search term highlighting
keymap('n', '<leader>n', '<cmd>nohlsearch<cr>', { desc = 'Turn-Off Search Term Highligthing' })
keymap('n', ',<esc>', '<cmd>nohlsearch<cr>', { desc = 'Turn-Off Search Term Highligthing' })

-- Search and Spelling - <leader>s ---------------------------------------------
keymap('n', '<leader>sp', '<cmd>setlocal spell!<cr>', { desc = '[SP]ell Toggle On/Off' })                     -- toggle on/off spell checking
--                                         '[s'               move to the previous misspelled word            -- key mapping is naively in neovim
--                                         ']s'               move to the next misspelled word                -- key mapping is naively in neovim
--                                         'z='               view spelling suggestions for a word            -- key mapping is naively in neovim
--                                         'zg'               add a word to the spelling dictionary           -- key mapping is natively in neovim
--                                         'zug'              undo the addition of a word to the dictionary   -- key mapping is natively in neovim

-- Buffer Management - <leader>a -----------------------------------------------
keymap('n', '<leader>an', '<cmd>enew<cr>', { desc = 'Open Unnamed [N]ew [B]uffer' })
--                            ':w <name>'           write the buffer to file named <name>

-- Jump to Location/File - <leader>j -------------------------------------------
keymap('n', '<leader>jd', '<cmd>cd %:p:h<cr><cmd>pwd<cr>', { desc = '[J]ump to [D]irectory of Buffers' })     -- change working directory to same as file within buffer

-- Toggle Feature On/Off - <leader>T -------------------------------------------
keymap('n', '<leader>Tsp', '<cmd>setlocal spell!<cr>', { desc = '[T]oggle [SP]ell On/Off' })                  -- toggle on/off spell checking
keymap('n', '<leader>Twy', '<cmd>set wrap<cr>', { desc = '[T]urn-On Line [W]rapping [Y]es' })                 -- key mapping for turning-on line wrapping
keymap('n', '<leader>Twn', '<cmd>set nowrap<cr>', { desc = '[T]urn-On Line [W]rapping [N]o' })                -- key mapping for turning-off line wrapping
keymap('n', '<leader>Tc', '<cmd>set list!<cr>', { desc = '[T]oggle Hidden [C]haracters' })                    -- key mappings for revealing hidden characters
vim.cmd [[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]]                                          -- enumerates which hidden characters to display and what character to use for displaying them

-- Format/Lint/Debug Code - <leader>c ------------------------------------------

-- Documentation/Definitions - <leader>d ---------------------------------------

-- Error/Diagnostic/Troubles - <leader>e ---------------------------------------
-- diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to Previous [D]iagnostic Message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to Next [D]iagnostic Message' })
keymap('n', '<leader>Ee', vim.diagnostic.open_float, { desc = 'Show Diagnostic [E]rror Messages' })
keymap('n', '<leader>Eq', vim.diagnostic.setloclist, { desc = 'Open Diagnostic [Q]uickfix List' })

-- Git Operations - <leader>g --------------------------------------------------

-- Workspace/Session Mgmt. - <leader>w -----------------------------------------


-- TIP: to enforce use of keys instead of arrow keys, disable arrow keys in normal mode
-- keymap('n', '<left>', '<cmd>echo "Use h to move cursor left!!"<CR>')
-- keymap('n', '<right>', '<cmd>echo "Use l to move cursor right!!"<CR>')
-- keymap('n', '<up>', '<cmd>echo "Use k to move cursor up!!"<CR>')
-- keymap('n', '<down>', '<cmd>echo "Use j to move cursor down!!"<CR>')

-- buffer management

-- window split management
keymap("n", "<leader>sv", "<C-w>v", { desc = "[S]plit Window [V]ertically" })      -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split Window Horizontally" })        -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", { desc = "Make [S]plits [E]qual Size" })       -- make split windows equal width & height
keymap("n", "<leader>sc", "<cmd>close<cr>", { desc = "[C]lose Current [S]plit" })  -- close current split window

-- keybinds to make split navigation easier, use CTRL+<hjkl> to switch between windows, see ":help wincmd" for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move Focus to the Left Window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move Focus to the Right Window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move Focus to the Lower Window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move Focus to the Upper Window' })

--[[
-- tab management
keymap("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Open New [T]ab" })                         -- open new tab
keymap("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "[C]lose Current [T]ab" })                -- close current tab
keymap("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Go To [N]ext [T]ab" })                    -- go to next tab
keymap("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Go To [P]revious [T]ab" })            -- go to previous tab
keymap("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open Current Buffer in New [T]ab" })     -- move current buffer to new tab
--]]

-- [[ Visual Mode ]] -----------------------------------------------------------
-- when typing commands while the visual area is highlighted

-- [[ Select Mode ]] -----------------------------------------------------------
-- like Visual mode but typing text replaces the selection

-- [[ Operator-pending Mode ]] -------------------------------------------------
-- when an operator is pending (after “d”, “y”, “c”, etc.), see ":help omap-info"

-- [[ Insert Mode ]] -----------------------------------------------------------
-- when inserting or replacing text
keymap('i', 'jk', '<esc>', { desc = "Exit Insert Mode with 'jk'" })

-- [[ Command-Line Mode ]] -----------------------------------------------------------
-- when requesting the vim operating system to take action with a ”:” or ”/” command
--the command-line mode map works in the following command prompts:
--    :    execute command prompt
--    /    forward search prompt
--    ?    backward search prompt
--    >    debug prompt
--    @    input() prompt
--    -    :insert and :append prompts

-- [[ Terminal Mode ]] ---------------------------------------------------------
-- when typing in terminal session buffer create with ":terminal"

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping or just use <C-\><C-n> to exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- [[ Basic Autocommands ]] ----------------------------------------------------
--  See ":help lua-guide-autocommands"

--[[
-- momentarily highlight when yanking (copying) text, try it with `yap` in normal mode, see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
--]]
-- highlight yanked text using the 'IncSearch' highlight group for 300ms
local HighlightYank = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = HighlightYank,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 300,
        })
    end,
})

-- remove trailing whitespace from all lines before saving a file
local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

--------------------------------------------------------------------------------

--[[
  Sources:
    [Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/#programming-specific-vim-key-bindings)
    [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
    [Vim Cheat Sheet](https://vim.rtorr.com/)

    Vim Modes
        Vim operates in distinct modes, each designed for specific tasks:
            Normal Mode: Default state for efficient movement, deletion, searching, and more
            Insert Mode: Allows you to type text directly into your file
            Visual Mode: Enables text selection for manipulation
            Command Mode: Using the ':' key, enter commands to NeoVim to perform operations

    Normal Mode
        Cursor Movement
            h  --> move cursor left                                             -- basic cursor movement
            j  --> move cursor down
            k  --> move cursor up
            l  --> move cursor right

            gg --> move cursor to the first line of the page                    -- moving cursor to top or bottom
            G  --> move cursor to the last line of the page

            :number --> moving cursor to the line number                        -- moving cursor to a specific line number

            $  --> move cursor to the end of the line                           -- moving cursor within a line or through words
            ^  --> move cursor to the start of the line
            b  --> move cursor to front of previous word
            w  --> move cursor to front of next word

            zz --> vertically center the page line when the cursor is located   -- page layout relative to the cursor

            Ctrl + u --> move cursor half a screen up                           -- scrolling up and down the page
            Ctrl + d --> move cursor half a screen down
            Ctrl + b --> move cursor one full screen up
            Ctrl + f --> move cursor one full screen down

            %  --> move cursor to the matching parenthesis, bracket, or brace   -- move to matching parentheses

            (  --> jumping cursor to the beginning of the previous sentence     -- jumping between words and paragraphs
            )  --> jumping cursor to the beginning of the next sentence
            {  --> jumping cursor to the beginning of the previous paragraph
            }  --> jumping cursor to the beginning of the next paragraph-

            x  --> delete the character under the cursor                        -- delete, copy, or paste character, word, or line
            dd --> delete the entire line
            yy --> copy (yank) the entire line
            p  --> paste the previously deleted or copied text after the cursor

            u  --> undo the last action                                         -- undo and redo actions taken
            Ctrl + r --> redo the undone action (aka undo the undo)

        Access File
            e  --> pull file into an empty buffer
            r  --> pull file into current buffer

        Search
            /{string}  --> start searching for text string forward              -- searching and replacing text strings
            ?{string}  --> start searching for text string backward
            n  --> goto the next matching text string
            :s/old/new/g --> replace all occurrences of 'old' with 'new' in the entire file

        Format
            >> --> indent the current line to the right by 'shiftwidth'         -- line indentation
            << --> indent the current line to the left by 'shiftwidth'
            == --> indent the current line according to your indentation settings
            gg=G --> re-indent an entire buffer

            zf{motion} --> create a fold ({motion} = movement command)          -- line folding (collapse/expand sections, makes it easier to focus on specific parts), see [Code Folding in Neovim](https://www.youtube.com/watch?v=f_f08KnAJOQ)
            zf#j --> creates a fold from the cursor down # lines
            zf/string --> creates a fold from the cursor to string
            zo --> opens a fold at the cursor
            zc --> close a fold
            za --> toggle fold open/closed
            zj --> moves the cursor to the next fold
            zk --> moves the cursor to the previous fold
            zO --> opens all folds at the cursor
            zm --> increase folding level throughout the file -- incresed by 1
            zr --> reduce folding level throughout the file -- decreased by 1
            zr --> decreases the foldlevel by one
            zM --> close all the folds in the file
            zR --> decreases the foldlevel to zero -- all folds will be open
            zd --> deletes the fold at the cursor
            zE --> deletes all folds
            [z --> move to start of open fold
            ]z --> move to end of open fold

            gcc --> comment/un-comment the current line                         -- comment and un-comment lines
            gc{motion} --> comment/un-comment the lines covered by {motion}

        Jump To
            gx --> open the URL or filepath that’s under your cursor

    Insert Mode
            Esc --> return to Normal Mode
            i  --> start inserting text before the cursor
            a  --> start inserting text after the cursor
            o  --> open a new line below the current line and start inserting text

    Visual Mode
            Esc --> return to Normal Mode
            v  --> start character-wise Visual Mode
            V  --> start line-wise Visual Mode
            Ctrl + v --> start block-wise Visual Mode
            d  --> delete the selected text
            y  --> copy (yank) the selected text
            p  --> paste the copied text after the cursor

    Command Mode
           :checkhealth --> check the health of neovim and its plugins
]]

