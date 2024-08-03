-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

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
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
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

