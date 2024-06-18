
--[[----------------------------------------------------------------------------
editor-enhanced/keymappings.lua

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
----------------------------------------------------------------------------]]--


--[[
-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be "n" = normal mode, "i" = insert mode, "v" = visual mode, "x" = visual block mode, "t" = term mode, "c" = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- ??
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- disabling arrow keys to force use of h, j, k, l keys for cursor navigation
--keymap('n', '<up>', '<nop>', opts)
--keymap('n', '<down>', '<nop>', opts)
--keymap('n', '<left>', '<nop>', opts)
--keymap('n', '<right>', '<nop>', opts)

keymap("n", "<Space>", "<Nop>", opts)                     -- map <Space> so its not the leader key

-- key mappings to support nvim-tree
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)     -- toggle on/off nvim-tree
keymap('n', '<leader>f', ':NvimTreeFindFile<cr>', opts)

-- if the search term highlighting gets annoying
keymap('n', '<leader>n', ':nohlsearch<cr>', opts)        -- clears the search highlights

-- key mappings to reveal hidden characters
keymap('n', '<leader>hc', ':set list!<cr>', opts)        -- toggle between showing and hiding hidden characters
vim.cmd[[set listchars=tab:>-,trail:.,extends:#,nbsp:.]]  -- enumerates which hidden characters to display and which character to display them with

--[[
-- key mappings to support spelling checker
keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
keymap('n', '<leader>sd', ']s', opts)                    --  move to the next misspelled word
keymap('n', '<leader>su', '[s', opts)                    --  move to the previous misspelled word
keymap('n', '<leader>sa', 'zg', opts)                    --  add a word to the dictionary
keymap('n', '<leader>sua', 'zug', opts)                  --  undo the addition of a word to the dictionary
keymap('n', '<leader>s?', 'z=', opts)                    --  view spelling suggestions for a misspelled word

-- use tab key to move through buffers
keymap('n', '<TAB>', ':bn<CR>', opts)                    -- move to next buffer
keymap('n', '<S-TAB>', ':bp<CR>', opts)                  -- move to previous buffer

-- key mappings to support barbar
keymap('n', '<leader>b+', '<Cmd>BufferNext<CR>', opts)       -- move to next buffer
keymap('n', '<leader>b-', '<Cmd>BufferPrevious<CR>', opts)   -- move to previous buffer

-- key mappings to goto buffer in position 'number'
keymap('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)

-- key mappings to toggle pin / unpin buffer
keymap('n', '<leader>bp', '<Cmd>BufferPin<CR>', opts)
]]--





-- [Install and Set Up Which Key in Neovim/Nvim And Never Forget Your Key Mappings](https://linovox.com/install-and-set-up-which-key-in-neovim-nvim/)
-- [Which-Key for Neovim](https://medium.com/@shaikzahid0713/which-key-7554ac347c9d)
-- [Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/)
-- [which-key.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=hB-k7VOCONs)

-- if you haven't loaded this plugin, do no operation and return
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("module 'lua/keymappings.lua' requires the plugin 'folke/which-key.nvim' to be installed")
  return
end


local setup = {
  plugins = {
    marks = true,                                                               -- shows a list of your marks on ' and `
    registers = true,                                                           -- shows your vim registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,                                                           -- enabling this will show WhichKey when pressing 'z=' to select spelling suggestions
      suggestions = 20,                                                         -- the number of spelling  word suggestions that should be shown in the list
    },
    presets = {                                                                 -- 'presets' plugin adds help for a bunch of default keybindings in neovim, no actual key bindings are created
      operators = true,                                                         -- adds help for operators like d, y, ... and registers them for motion / text object completion (things like 'change word', 'yank', etc.)
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


local opts = {
  mode = "n",                                                                   -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,                                                                 -- global mappings, specify a buffer number for buffer local mappings
  silent = true,                                                                -- use `silent` when creating keymaps
  noremap = true,                                                               -- use `noremap` when creating keymaps
  nowait = true,                                                                -- use `nowait` when creating keymaps
}

local mappings = {
--a
  b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Buffers", },
  c = { "<cmd>bdelete<cr>", "Close Buffer" },                                   -- close current file
  d = { "<cmd>cd %:p:h<cr>:pwd<cr>", "Change Working Directory to Buffer" },    -- change working directory to same as file within buffer
  e = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree Explorer Window" },
  f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find files", },
  F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
--g
  h = { "<cmd>nohlsearch<cr>", "No Highlight" },
  i = { "<cmd>set list!<cr>", "Show/Hide Hidden Characters" },                  -- toggle between showing and hiding hidden characters, see below: vim.cmd([[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]])
--j
--k
--l
--m
  n = { "<cmd>nohlsearch<cr>", "Clear Search Highlights" },                     -- if the search term highlighting gets annoying, turn-off search term highlighting
--o
  p = { "<cmd>Lazy<cr>", "Plugin Manager" },                                    -- invoking plugin manager
--q
--r
--s
--t
  w = {           -- Line Wrapping
    name = "Line Wrapping",
    w = { "<cmd>set wrap<cr>", "Turn-On Line Wrapping" },                       -- wrap long line around and don't extend off the window
    n = { "<cmd>set nowrap<cr>", "Turn-Off Line Wrapping" },                    -- no line wrapping, extend text beyond the windows edge
  },
--x
--y
--z


  ---- Packer
  --p = {
    --name = "Packer",
    --c = { "<cmd>PackerCompile<cr>", "Compile" },
    --i = { "<cmd>PackerInstall<cr>", "Install" },
    --s = { "<cmd>PackerSync<cr>", "Sync" },
    --S = { "<cmd>PackerStatus<cr>", "Status" },
    --u = { "<cmd>PackerUpdate<cr>", "Update" },
  --},

  -- Harpoon
  H = {
    name = "Harpon",
    x = { "<cmd>lua function() required('harpoon.mark').add_file() end<cr>", "Mark file" },
  },

  -- Git
  G = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
  },

  -- Language Server Protocol (LSP)
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics", },
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
  },

  -- NeoVim Native Spell Checking                                               -- inline spell check is disabled at startup (see 'options.lua' file)
  s = {
    name = "Spell Checker",
    p = { "<cmd>setlocal spell!<cr>", "Spell Checking Toggle On/Off" },
    r = { "<cmd>spellr<cr>", "Spell Replacement Whole File" },
    -- '[s' move to the previous misspelled word                                -- keys are mapped natively in neovim
    -- ']s' move to the next misspelled word                                    -- keys are mapped natively in neovim
    -- 'z=' view spelling suggestions for a misspelled word                     -- keys are mapped natively in neovim
    -- 'zg' add a word to the spelling dictionary                               -- keys are mapped natively in neovim
    -- 'zug' undo the addition of a word to the dictionary                      -- keys are mapped natively in neovim
  },

  --Telescope
  S = {
    name = "Telescope",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  -- Terminal
  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

}

vim.cmd([[set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ ]])           -- enumerates which hidden characters to display and which character to display them with
which_key.setup(setup)
which_key.register(mappings, opts)

