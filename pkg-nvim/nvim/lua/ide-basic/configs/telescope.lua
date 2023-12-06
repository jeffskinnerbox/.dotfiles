
--------------------------------------------------------------------------------
-- ide-basic/telescope.lua

-- Telescope is a highly extendable fuzzy finder over lists. It is built on the
-- latest features from neovim core and it emphasizes modularity, allowing for
-- easy customization. Telescope uses the fuzzy file finder, 'fzf' to help
-- us find files efficiently, among other things.

-- Telescope effectively extends the native file search capabilities in
-- NeoVim e.g. :find <file>) beyond its search path (e.g. :set path?).

-- Sources:
--    [Neovim - Telescope: a highly extendable fuzzy finder](https://www.youtube.com/watch?v=OhnLevLpGB4)
--    [GitHub: nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
--    [Telescope Extensions](https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions)
--    [Vim universe. fzf - command line fuzzy finder](https://www.youtube.com/watch?v=qgG5Jhi_Els)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("'configs/telescope.lua' module had an error")
  return
end


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be "n" = normal mode, "i" = insert mode, "v" = visual mode, "x" = visual block mode, "t" = term mode, "c" = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- keymap options
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local term_opts = { silent = true }

-- key mappings for telescope navigation and searching
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<cr>", opts)
keymap("n", "<leader>fe", ":Telescope file_browser<cr>", opts)
keymap("n", "<leader>fw", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>fo", ":Telescope oldfiles<cr>", opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<cr>", opts)


local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {     -- insert mode
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {     -- normal mode
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- to get telescope-file-browser loaded and working with telescope, you need to call load_extension, somewhere after setup function
require("telescope").load_extension "file_browser"

