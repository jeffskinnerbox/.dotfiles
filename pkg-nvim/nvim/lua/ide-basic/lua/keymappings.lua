
--[[----------------------------------------------------------------------------
ide-basic/keymappings.lua

This file maps key combinations to change the meaning of typed keys. Typically
this would be to perfromal an editoral operation or execute a function.

To view all of the keys maps for the current buffer by all of plugins, modules, etc,
use the `nmap` command:

     ':nmap' for normal mode mappings
     ':vmap' for visual mode mappings
     ':imap' for insert mode mappings

Enter ':help map' for a complete list
If you're using Telescope, then you can use ':Telescope keymaps' to
view/fuzzy search them.

Sources
    [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
    [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
    [Install and Set Up Which Key in Neovim/Nvim And Never Forget Your Key Mappings](https://linovox.com/install-and-set-up-which-key-in-neovim-nvim/)
    [Which-Key for Neovim](https://medium.com/@shaikzahid0713/which-key-7554ac347c9d)
    [Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/)
    [which-key.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=hB-k7VOCONs)
----------------------------------------------------------------------------]]--

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

            /{string}  --> start searching for text string forward                      -- searching and replacing text strings
            ?{string}  --> start searching for text string backward
            n  --> goto the next matching text string
            :s/old/new/g --> replace all occurrences of 'old' with 'new' in the entire file

            >> --> indent the current line to the right by 'shiftwidth'         -- line indentation
            << --> indent the current line to the left by 'shiftwidth'
            == --> indent the current line according to your indentation settings
            gg=G --> re-indent an entire buffer

            zf{motion} --> create a fold ({motion} = movement command)          -- line folding (collapse/expand sections, makes it easier to focus on specific parts)
            zo --> open a fold
            zc --> close a fold
            zr --> reduce folding level throughout the file
            zm --> increase folding level throughout the file

            gcc --> comment/un-comment the current line                          -- comment and un-comment lines
            gc{motion} --> comment/un-comment the lines covered by {motion}

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
]]--


-- if you haven't loaded this plugin, do no operation and return
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("module 'lua/keymappings.lua' requires the plugin 'folke/which-key.nvim' to be installed")
  require("notify")("module 'lua/keymappings.lua' requires the plugin 'folke/which-key.nvim' to be installed")
  return
end


-- setup function for the 'folke/which-key.nvim' plugin
local setup = {
  plugins = {
    marks = true,                                                               -- shows a list of your marks on ' and `
    registers = true,                                                           -- shows your vim registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,                                                           -- enabling this will show WhichKey when pressing 'z=' to select spelling suggestions
      suggestions = 20,                                                         -- the number of spelling  word suggestions that should be shown in the list
    },
    presets = {                                                                 -- 'presets' plugin adds help for a bunch of default keybindings in neovim, no actual key bindings are created
      operators = false,                                                         -- adds help for operators like d, y, ... and registers them for motion / text object completion (things like 'change word', 'yank', etc.)
      motions = true,                                                           -- adds help for motions (examples: i, j, k, l)
      text_objects = true,                                                      -- help for text objects triggered after entering an operator
      windows = true,                                                           -- default bindings on <c-w> (things like switching windows)
      nav = true,                                                               -- misc bindings to work with windows
      z = true,                                                                 -- bindings for folds, spelling, and others prefixed with z
      g = true,                                                                 -- bindings for prefixed with g (example comments plugin)
  },
  },
  operators = { gc = "Comments" },                                              -- add operators that will trigger motion and text object completion, to enable all native operators, set the preset / operators plugin above
  key_labels = { },                                                             -- override the label used to display some keys, it doesn't effect WK in any other way, (example: ["<space>"] = "SPC", ["<cr>"] = "RET", ["<tab>"] = "TAB")
  icons = {
    breadcrumb = "»",                                                           -- symbol used in the command line area that shows your active key combo
    separator = "➜",                                                            -- symbol used between a key and it's label
    group = "+",                                                                -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>",                                                      -- binding to scroll down inside the popup
    scroll_up = "<c-u>",                                                        -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",                                                         -- none, single, double, shadow
    position = "bottom",                                                        -- bottom, top
    margin = { 1, 0, 1, 0 },                                                    -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 },                                                   -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  triggers_blacklist = {                                                        -- triggers = {"<leader>"} -- or specify a list manually
    -- list of mode / prefixes that should never be hooked by WhichKey,
    -- this is mostly relevant for key maps that start with a native binding,
    -- most people should not need to change this
    i = { "j", "k" },                                                           -- do not override up & down cursor movement keys
    v = { "j", "k" },
  },
}


-- key mapping registration function for the 'folke/which-key.nvim' plugin
-- to take action, these key characters must be preceeded by the <leader> key
local mappings = {
--a
  b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.hemes').get_dropdown{previewer = false})<cr>", "List Buffers", },
  c = { "<cmd>bdelete<cr>", "Close Current Buffer" },                           -- close current file
  d = { "<cmd>cd %:p:h<cr>:pwd<cr>", "Change Working Directory to Buffer" },    -- change working directory to same as file within buffer
  e = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree Explorer Window" },
  E = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "List Files in Working Directory", },
--f
  F = { ------------------------------Telescope -------------------------------
    name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find a File" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    a = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    x = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    d = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
--g    -- nvim-treesitter/nvim-treesitter (specifically 'incremental_selection') is using this for keymaps
       -- numToStr/Comment.nvim has set the following keymapps:
       --     Normal Mode
       --         gcc - toggles the current line using linewise comment
       --         gbc - toggles the current line using blockwise comment
       --     Visual Mode
       --         gc - toggles the region using linewise comment
       --         gb - toggles the region using blockwise comment

  G = { ------------------------- Git Version Control -------------------------
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
    j = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage Hunk", },
  },
--h =   ------------------------------- Used by lewis6991/gitsigns.nvim -------------------------------
        ---- Actions
        --map('n', '<leader>hs', gitsigns.stage_hunk)
        --map('n', '<leader>hr', gitsigns.reset_hunk)
        --map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        --map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        --map('n', '<leader>hS', gitsigns.stage_buffer)
        --map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        --map('n', '<leader>hR', gitsigns.reset_buffer)
        --map('n', '<leader>hp', gitsigns.preview_hunk)
        --map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        --map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        --map('n', '<leader>hd', gitsigns.diffthis)
        --map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        --map('n', '<leader>td', gitsigns.toggle_deleted)
        ---- Text object
        --map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  H = { ------------------------------- Harpoon -------------------------------
    name = "Harpoon",
    x = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Harpoon Mark File" },  -- mark a file
    n = { "<cmd>lua require('harpoon.ul').nav_next()<cr>", "Goto Next Marked File" },
    p = { "<cmd>lua require('harpoon.ul').nav_prev()<cr>", "Goto Previous Marked File" },
    m = { "<cmd>Telescope harpoon marks<cr>", "Show All Harpoon Marks" },       -- show all the harpoon marks we have set
  },
--i
  I = { ----------------------- Toggle On/Off Features ------------------------
    name = "Toggle On/Off Features",
    c = { "<cmd>ColorizerToggle<cr>", "Show/Hide Colorized Color Codes" },      -- toggle between showing and hiding colorized color codes, only works for current buffer
    i = { "<cmd>set list!<cr>", "Show/Hide Hidden Characters" },                -- toggle between showing and hiding hidden characters, see below: vim.cmd([[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]])
  },
--j
--k
--l
  L = { -------------------- Language Server Protocol (LSP) -------------------
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic", },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols", },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics", },
  },
--m
  M = { --------------------- Markdown Preview in Browser ---------------------
    name = "Markdown Preview in Browser",
    a = { "<cmd>MarkdownPreview<cr>", "Start Markdown Preview", },              -- format and send markdown file to your browser
    z = { "<cmd>MarkdownPreviewStop<cr>", "Stop Markdown Preview", },           -- terminate the formatting of the markdown file
    t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview", },       -- toggle on/off the markdown file formatting
  },
  n = { "<cmd>nohlsearch<cr>", "Clear Search Highlights" },                     -- if the search term highlighting gets annoying, turn-off search term highlighting
--o
  p = { "<cmd>Lazy show<cr>", "Lazy Plugin Manager Show Status" },              -- invoking lazy plugin manager
  P = { ------------------------- Lazy Plugin Manager -------------------------
    name = "Lazy",
    c = { "<cmd>Lazy clean<cr>", "Remove Plugins No Longer Needed" },
    h = { "<cmd>Lazy help<cr>", "Popup Lazy Help Page" },
    i = { "<cmd>Lazy install<cr>", "Install Missing Plugins" },
    s = { "<cmd>Lazy show<cr>", "Popup Lazy Control & Status Screen" },
    S = { "<cmd>Lazy sync<cr>", "Sync: Install + Clean + Update" },
    u = { "<cmd>Lazy update<cr>", "Update All Plugins,, Lockfile" },
  },
--q
--r
  s = { --------------------- NeoVim Native Spell Checking  ------------------- -- inline spell check is disabled at startup (see 'options.lua' file)
    name = "Spelling Check",
    p = { "<cmd>setlocal spell!<cr>", "Toggle Highlighting of Misspelled Words" },
    -- '[s' move to the previous misspelled word                                -- key mapping is naively in neovim
    -- ']s' move to the next misspelled word                                    -- key mapping is naively in neovim
    -- 'z=' view spelling suggestions for a word                                -- key mapping is naively in neovim
    -- 'zg' add a word to the spelling dictionary                               -- key mapping is natively in neovim
    -- 'zug' undo the addition of a word to the dictionary                      -- key mapping is natively in neovim
  },
--t
  T = { ------------------------------ Terminal -------------------------------
    name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },                     -- floating terminal
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },   -- horizontal terminal,
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },                              -- node terminal
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },                          -- if you have python, run it in a terminal
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },                              -- if you have htop, run it in a terminal
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },       -- vertical terminal
  },
--w
  W = { --------------------------- Text Line Wrapping ------------------------
    name = "Line Wrapping",
    n = { "<cmd>set nowrap<cr>", "Turn-Off Line Wrapping" },                    -- no line wrapping, extend text beyond the windows edge
    w = { "<cmd>set wrap<cr>", "Turn-On Line Wrapping" },                       -- wrap long line around and don't extend off the window
  },
--x
--y
--z
}


-- option values passed to key mapping registration function for the 'folke/which-key.nvim' plugin
local opts = {
  mode = "n",                                                                   -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,                                                                 -- global mappings, specify a buffer number for buffer local mappings
  silent = true,                                                                -- use `silent` when creating keymaps
  noremap = true,                                                               -- use `noremap` when creating keymaps
  nowait = true,                                                                -- use `nowait` when creating keymaps
}


-- execute the 'folke/which-key.nvim' plugin setup and register functions
vim.cmd([[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]])           -- enumerates which hidden characters to display and which character to display them with
which_key.setup(setup)
which_key.register(mappings, opts)

