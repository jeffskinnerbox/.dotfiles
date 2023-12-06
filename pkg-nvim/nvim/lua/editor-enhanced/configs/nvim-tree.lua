
--------------------------------------------------------------------------------
-- editor-enhanced/nvim-tree.lua

-- NeoVimTree is a file system navigator for NeoVim written in lua.  Its a Lua
-- alternative to NerdTree and Vim's native navigator netrw.

-- Commandline
    -- ':NvimTreeToggle' -  open or close the tree
    -- '<leader>e' - same as above
    -- ':NvimTreeFocus' -  open the tree if it is closed, and then focus on the tree
    -- ':NvimTreeFindFile' -  move the cursor in the tree for the current buffer, opening folders if needed
    -- ':NvimTreeCollapse' -  collapses the nvim-tree recursively

-- While in NvimTree
    -- 'a' - add a file to the filesystem at the selected directory
    -- 'o' - open a file and stay in file explorer
    -- 'r' - rename the file or directory
    -- 'd' - to delete file or directory

-- Sources:
--   [Github: nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
--   [Migrate from NerdTree to NvimTree](https://taoshu.in/vim/migrate-nerdtree-to-nvim-tree.html)
--   [File Explorer for Neovim](https://medium.com/@shaikzahid0713/file-explorer-for-neovim-c324d2c53657)
--   [Neovim - NvimTree File Explorer Written In Lua](https://www.youtube.com/watch?v=SpexCBrZ1pQ)
--   [GitHub: LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch/blob/12-nvimtree/lua/user/nvim-tree.lua)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("'configs/nvim-tree.lua' module had an error")
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- key_mapper(<mode>, <key-to-bind>, <action-wanted>)
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    { noremap = true, silent = true }
  )
end

key_mapper('', '<leader>e', ':NvimTreeToggle<cr>')     -- toggle on/off nvim-tree
key_mapper('', '<leader>f', ':NvimTreeFindFile<cr>')   -- move the cursor in the tree for the current buffer,


-- for the most part, the following options are the defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  --open_on_setup = false,                  -- cause 'unknown option' error, something must have changed
  --ignore_ft_on_setup = {                  -- cause 'unknown option' error, something must have changed
    --"startify",
    --"dashboard",
    --"alpha",
  --},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    --height = 30,                          -- cause 'unknown option' error, something must have changed
    hide_root_folder = false,
    side = "left",
    --auto_resize = true,                   -- cause 'unknown option' error, something must have changed
    mappings = {
      custom_only = false,
      list = {
      { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "h", cb = tree_cb "close_node" },
      { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
  actions = {
    --quit_on_open = true,                  -- cause 'unknown option' error, something must have changed
    --window_picker = { enable = true },    -- cause 'unknown option' error, something must have changed
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    }
  }
}
