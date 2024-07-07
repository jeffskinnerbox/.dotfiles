--[[ plugin lets you find, filter, preview, pick directories, files, buffers, words 
kickstart2/lua/kickstart/plugins/telescope.lua

  Description:
    You can use Telescope for so much of things! File browser, notification history,
    keymaps browser, filetypes picker, diagnostics, git, DAP command picker, and so on.
    It's a such fundamental tool that I can't imagine using Neoivm without it.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :Telescope               - list of Telescope commands

    Keymapped Commands
      <leader>sh               - lists available help tags and opens a new window with the relevant help info on <cr>
      <leader>sk               - lists normal mode keymappings, runs the selected keymap on `<cr>`
      <leader>sf               - list all files and search for files name (respecting .gitignore)
      <leader>sb               - lists open buffers in current neovim instance, opens selected buffer on `<cr>
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

-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        enabled = true,

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim', enabled = true },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
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

      -- [[ Configure Telescope ]]
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
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp Info.' }) -- lists available help tags and opens a new window with the relevant help info on <cr>
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' }) -- lists normal mode keymappings, runs the selected keymap on `<cr>`
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles in Working Dierectory' }) -- list all files and search for files name (respecting .gitignore)
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' }) -- lists open buffers in current neovim instance, opens selected buffer on `<cr>
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Within Telescope' }) -- lists all of the community maintained pickers built into Telescope
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch for [W]ord in Working Directory' }) -- searches for the string under your cursor in your current working director
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch All Files by [G]rep a String' }) -- search all files for a string and get results live as you type, respects .gitignore
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics Messages' }) -- list diagnostic messages identified by treesitter and ???
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume Previous Operation' }) -- opens the previous operated picker in the identical state (incl. multi selections)
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch ALL Recent Files ("." for repeat)' }) -- lists previously open files, opens on `<cr>`

      -- do a live grep on the open files in your buffers
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch Buffers via Grep' })

      -- searching your neovim configuration files (aka standard path)
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim Configuration Files' })

      -- fuzz search your current buffer
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown { -- you can pass additional configuration to Telescope to change the theme, layout, etc.
            winblend = 10,
            previewer = false,
          }
        )
      end, { desc = '[/] Fuzz Search in Current Buffer' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
