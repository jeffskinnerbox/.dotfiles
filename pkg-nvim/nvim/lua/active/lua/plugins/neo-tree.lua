-- luacheck: globals vim
-- luacheck: max line length 300

--[[ Neo-tree is a Neovim plugin to browse the file system
kickstart2/lua/kickstart/plugins/neo-tree.lua

    [GitHub: nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
]]

return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',                                              -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    --"3rd/image.nvim",                                                         -- optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = 'Neotree',
  keys = {
    { '\\', '<CMD>Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}

