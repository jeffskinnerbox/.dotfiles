-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin lets you find, filter, preview, pick directories, files, buffers, words
kickstart2/lua/kickstart/plugins/telescope.lua

  Description:
    You can use Telescope for so much of things! File browser, notification history,
    keymaps browser, filetypes picker, diagnostics, git, DAP command picker, and so on.
    It's a such fundamental tool that I can't imagine using Neoivm without it.

  Definitions:
    Definitions of phrases when it could be helpful.
      Quickfix list
      Pickers                FIX: needs to be updated
        File Pickers
        Vim Pickers
            .
            .
            .
        Sorters
        Layout


  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :Telescope               - list of Telescope commands

    Keymapped Commands
      Default Mappings         - https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#default-mappings    FIX: needs to be updated
      <leader>sh               - lists available help tags and opens a new window with the relevant help info on <cr>
      <leader>sk               - lists normal mode keymappings, runs the selected keymap on `<cr>`
      <leader>sf               - list all files and search for files name (respecting .gitignore)
      <leader>sb               - lists open buffers in current neovim instance, opens selected buffer on `<cr>     FIX: needs to be updated
      <leader>ss               - lists all of the community maintained pickers built into Telescope
      <leader>sw               - searches for the string under your cursor in your current working director
      <leader>sg               - search All files for a string and get results live as you type, respects .gitignore
      <leader>sd               - list diagnostic messages identified by treesitter and ???
      <leader>sr               - opens the previous operated picker in the identical state (incl. multi selections)
      <leader>s.               - lists previously open files, opens on `<cr>`
      <leader>s/               - do a live grep on the open files in your buffers
      <leader>sn               - searching your neovim configuration files (aka standard path)
      <leader>/                - fuzz search your current buffer

  Sources:
    [GitHub: nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    [telescope.nvim -Weekly Neovim Plugin](https://www.youtube.com/watch?v=Mk47CZaGeWw)
    [Neovim - Telescope: a highly extendable fuzzy finder](https://www.youtube.com/watch?v=OhnLevLpGB4)
    [Configure Telescope in Neovim](https://www.youtube.com/watch?v=u_OORAL_xSM)
]]

-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    { desc = 'TS: ' .. options }                                                -- aka {opts}, keymap discription, 'TS:' means this is a telescope function
  )
end

-- taken from https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',                                                    -- some lua functions that telescope needs
    'nvim-tree/nvim-web-devicons',                                              -- dev icons for telescope
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },             -- function that improves telescope's sorting perfromance
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')                                -- used to configure key mappings
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {                                                                 -- these key mappings will be for insert mode
            ['<C-k>'] = actions.move_selection_previous,                        -- move to prev result
            ['<C-j>'] = actions.move_selection_next,                            -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,  -- send telescope results to the quickfix list
          },
        },
      },
    })

    -- load the 'fzf' extension
    telescope.load_extension('fzf')                                             -- load the 'fzf' extension to telescope which imporves its sorting perfromanace

    -- set telescope keymaps
    keymap('n', '<leader>fb', builtin.buffers, '[S]earch [B]uffers' )                         -- lists open buffers in current neovim instance, opens selected buffer on `<cr>
    keymap('n', '<leader>fc', builtin.grep_string, '[F]ind String Under [C]ursor in cwd' )    -- searches for the string under your cursor in your current working director
    keymap('n', '<leader>fd', builtin.diagnostics, '[F]ind [D]iagnostics Messages' )          -- list diagnostic messages identified by treesitter and ???
    keymap('n', '<leader>ff', builtin.find_files, 'Fuzzy [F]ind [F]iles in cwd')              -- list all files and search for files name (respecting .gitignore)
    keymap('n', '<leader>fh', builtin.help_tags, '[F]ind [H]elp Info.' )                      -- lists available help tags and opens a new window with the relevant help info on <cr>
    keymap('n', '<leader>fk', builtin.keymaps, '[F]ind [K]eymaps' )                           -- lists normal mode keymappings, runs the selected keymap on `<cr>`
    keymap('n', '<leader>fo', builtin.resume, '[F]ind Resume Previous [O]peration' )          -- opens the previous operated picker in the identical state (incl. multi selections)
    keymap('n', '<leader>fp', builtin.builtin, '[F]ind [P]icker Within Telescope' )           -- lists all of the community maintained pickers built into Telescope
    keymap('n', '<leader>s.', builtin.oldfiles, '[F]ind ALL Recent Files ("." for repeat)' )  -- lists previously open files, opens on `<cr>`
    keymap('n', '<leader>fs', builtin.live_grep, '[S]earch All Files by [G]rep a String' )    -- search all files for a string and get results live as you type, respects .gitignore
    keymap('n', '<leader>ft', '<cmd>TodoTelescope<cr>', '[F]ind [T]oDos')
  end,
}

