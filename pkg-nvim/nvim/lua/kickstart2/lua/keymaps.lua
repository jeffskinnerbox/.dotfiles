--[[
kickstart2/lua/keymaps.lua

    Description:
      This file maps key combinations to change the meaning of typed keys. Typically
      this would be to perfromal an editoral operation or execute a function.

    As outlined in the 'whick-key.lua' plugin, I'm organizing my key mappings
    in these large 'key' buckets:

          Search and Spelling        - <leader>s
          Jump to Location/File      - <leader>j
          Toggle Feature On/Off      - <leader>t
          Format/Lint/Debug Code     - <leader>c
          Documentation/Definitions  - <leader>d
          Error/Diagnostic Messages  - <leader>e
          Git Operations             - <leader>g
          Workspace/Session Mgmt.    - <leader>w

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
]]

-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    options                                                                     -- aka {opts}, keymap options
  )
end

-- [[ Normal Mode ]] -----------------------------------------------------------
-- a neutral state, waiting for user to input something

-- turn-off search term highlighting
vim.opt.hlsearch = true -- turn on search term highlighting
keymap('n', '<leader>n', '<cmd>nohlsearch<cr>', { desc = 'Turn-Off Search Term Highligthing' })
keymap('n', ',<esc>', '<cmd>nohlsearch<cr>', { desc = 'Turn-Off Search Term Highligthing' })

-- Search and Spelling - <leader>s ---------------------------------------------
keymap('n', '<leader>sp', '<cmd>setlocal spell!<cr>', { desc = '[SP]ell Toggle On/Off' }) -- toggle on/off spell checking
--                                         '[s'               move to the previous misspelled word            -- key mapping is naively in neovim
--                                         ']s'               move to the next misspelled word                -- key mapping is naively in neovim
--                                         'z='               view spelling suggestions for a word            -- key mapping is naively in neovim
--                                         'zg'               add a word to the spelling dictionary           -- key mapping is natively in neovim
--                                         'zug'              undo the addition of a word to the dictionary   -- key mapping is natively in neovim

-- Jump to Location/File - <leader>j -------------------------------------------
keymap('n', '<leader>jd', '<cmd>cd %:p:h<cr><cmd>pwd<cr>', { desc = '[J]ump to [D]irectory of Buffers' })     -- change working directory to same as file within buffer

-- Toggle Feature On/Off - <leader>t -------------------------------------------
keymap('n', '<leader>twy', '<cmd>set wrap<cr>', { desc = '[T]urn-On Line [W]rapping [Y]es' })                 -- key mapping for turning-on line wrapping
keymap('n', '<leader>twn', '<cmd>set nowrap<cr>', { desc = '[T]urn-On Line [W]rapping [N]o' })                -- key mapping for turning-off line wrapping
keymap('n', '<leader>tc', '<cmd>set list!<cr>', { desc = '[T]oggle Hidden [C]haracters' })                    -- key mappings for revealing hidden characters
vim.cmd [[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]]                                          -- enumerates which hidden characters to display and what character to use for displaying them

-- Format/Lint/Debug Code - <leader>c ------------------------------------------
-- Documentation/Definitions - <leader>d ---------------------------------------
-- Error/Diagnostic Messages - <leader>e ---------------------------------------
-- Git Operations - <leader>g --------------------------------------------------
-- Workspace/Session Mgmt. - <leader>w -----------------------------------------

-- diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic [E]rror Messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic [Q]uickfix List' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to Previous [D]iagnostic Message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to Next [D]iagnostic Message' })

-- keybinds to make split navigation easier, use CTRL+<hjkl> to switch between windows, see ":help wincmd" for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move Focus to the Left Window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move Focus to the Right Window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move Focus to the Lower Window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move Focus to the Upper Window' })

-- TIP: to enforce use of keys instead of arrow keys, disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- [[ Visual Mode ]] -----------------------------------------------------------
-- when typing commands while the visual area is highlighted

-- [[ Select Mode ]] -----------------------------------------------------------
-- like Visual mode but typing text replaces the selection

-- [[ Operator-pending Mode ]] -------------------------------------------------
-- when an operator is pending (after “d”, “y”, “c”, etc.), see ":help omap-info"

-- [[ Insert Mode ]] -----------------------------------------------------------
-- when inserting or replacing text

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
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- [[ Basic Autocommands ]] ----------------------------------------------------
--  See ":help lua-guide-autocommands"

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--------------------------------------------------------------------------------

--[[
[Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/#programming-specific-vim-key-bindings)
[Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
   Vim Modes
        Vim operates in distinct modes, each designed for specific tasks:
            Normal Mode: Default state for efficient movement, deletion, searching, and more.
            Insert Mode: Allows you to type text directly into your file.
            Visual Mode: Enables text selection for manipulation.
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
            zf#j --> creates a fold from the cursor down # lines.
            zf/string --> creates a fold from the cursor to string
            zo --> opens a fold at the cursor
            zc --> close a fold
            za --> toggle fold open/closed
            zj --> moves the cursor to the next fold.
            zk --> moves the cursor to the previous fold.
            zO --> opens all folds at the cursor.
            zm --> increase folding level throughout the file -- incresed by 1
            zr --> reduce folding level throughout the file -- decreased by 1
            zr --> decreases the foldlevel by one.
            zM --> close all the folds in the file
            zR --> decreases the foldlevel to zero -- all folds will be open
            zd --> deletes the fold at the cursor.
            zE --> deletes all folds.
            [z --> move to start of open fold.
            ]z --> move to end of open fold.

            gcc --> comment/un-comment the current line                          -- comment and un-comment lines
            gc{motion} --> comment/un-comment the lines covered by {motion}

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

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
