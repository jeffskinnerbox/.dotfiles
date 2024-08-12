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
    { desc = 'TS: ' .. options }                                                -- aka {opts}, keymap options
  )
end

-- taken from https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',                                              -- https://github.com/nvim-telescope/telescope.nvim
  enabled = true,
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
    --local transform_mod = require("telescope.actions.mt").transform_mod
    --local trouble = require("trouble")
    --local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    --local custom_actions = transform_mod({
    --open_trouble_qflist = function(prompt_bufnr)
    --trouble.toggle("quickfix")
    --end,
    --})

    telescope.setup({
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {                                                                 -- these key mappings will be for insert mode
            ['<C-k>'] = actions.move_selection_previous,                        -- move to prev result
            ['<C-j>'] = actions.move_selection_next,                            -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,  -- send telescope results to the quickfix list
            --["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            --["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension('fzf')                                             -- load the 'fzf' extension to telescope which imporves its sorting perfromanace

    -- set keymaps
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Fuzzy [F]ind [F]iles in cwd")
    keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Fuzzy [F]ind [R]ecent Files")
    keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", "[F]ind [S]tring in cwd")
    keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", "[F]ind String Under [C]ursor in cwd")
    keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", "[F]ind [T]oDos")
  end,
}

--[[  -- from Kickstart
return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim', enabled = true },
    { 'nvim-telescope/telescope-ui-select.nvim', enabled = true },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },          -- useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-telescope/telescope-fzf-native.nvim', enabled = true,               -- if encountering errors, see telescope-fzf-native README for installation instructions
      build = 'make',                                                           -- `build` is used to run some command when the plugin is installed/updated, this is only run then, not every time Neovim starts up
      cond = function()                                                         -- `cond` is a condition used to determine whether this plugin should be installed and loaded
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    --  Configure Telescope
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({
            -- even more opts
          }),
          --pseudo code / specification for writing custom displays, like the one for 'codeactions'
          --specific_opts = {
          --  [kind] = {
          --    make_indexed = function(items) -> indexed_items, width,
          --    make_displayer = function(widths) -> displayer
          --    make_display = function(displayer) -> function(e)
          --    make_ordinal = function(e) -> string
          --  },
          --  -- for example to disable the custom builtin "codeactions" display
          --     do the following
          --  codeactions = false,
          --}
        },
      },
    }

    -- enable telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')                     -- to get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp Info.' })                      -- lists available help tags and opens a new window with the relevant help info on <cr>
    keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })                           -- lists normal mode keymappings, runs the selected keymap on `<cr>`
    keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles in Working Dierectory' })    -- list all files and search for files name (respecting .gitignore)
    keymap('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })                           -- lists open buffers in current neovim instance, opens selected buffer on `<cr>
    keymap('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Within Telescope' })           -- lists all of the community maintained pickers built into Telescope
    keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch for [W]ord in Working Directory' }) -- searches for the string under your cursor in your current working director
    keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch All Files by [G]rep a String' })      -- search all files for a string and get results live as you type, respects .gitignore
    keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics Messages' })          -- list diagnostic messages identified by treesitter and ???
    keymap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume Previous Operation' })          -- opens the previous operated picker in the identical state (incl. multi selections)
    keymap('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch ALL Recent Files ("." for repeat)' })  -- lists previously open files, opens on `<cr>`

    -- do a live grep on the open files in your buffers
    keymap('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch Buffers via Grep' })

    -- searching your neovim configuration files (aka standard path)
    keymap('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim Configuration Files' })

    -- fuzz search your current buffer
    keymap('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {                              -- you can pass additional configuration to Telescope to change the theme, layout, etc.
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = '[/] Fuzz Search in Current Buffer' })
  end,
}
]]
