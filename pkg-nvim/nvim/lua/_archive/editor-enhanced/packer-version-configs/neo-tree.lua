
--------------------------------------------------------------------------------
-- editor-enhanced/neo-tree.lua

-- Nvim-tree is a Neovim plugin to browse the file system and other tree like
-- structures in whatever style suits you, including sidebars, floating windows,
-- split style, file icons or all of them at once!

--   :help neo-tree-configuration - details on how to configure everything
--   :Neotree - opens on your current location
--   :Neotree <filesystem> - opens on the <filesystem>
--   :Neotree close - closes the neo-tree window
--   :q - closes the neo-tree window

-- Sources:
--   [GitHub: nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
--   [File Explorer for Neovim](https://medium.com/@shaikzahid0713/file-explorer-for-neovim-c324d2c53657)
--   []()
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, "neo-tree")
if not status_ok then
  print("'configs/neo-tree.lua' module had an error")
  return
end


-- setup your plugin options & features
-- this configuration should fix broken icons if you are using nerd fonts v3
require("neo-tree").setup({
  default_component_configs = {
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
    },
    git_status = {
      symbols = {
        renamed   = "󰁕",
        unstaged  = "󰄱",
      },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "󰈙", hl = "Tag" },
      Namespace = { icon = "󰌗", hl = "Include" },
      Package = { icon = "󰏖", hl = "Label" },
      Class = { icon = "󰌗", hl = "Include" },
      Property = { icon = "󰆧", hl = "@property" },
      Enum = { icon = "󰒻", hl = "@number" },
      Function = { icon = "󰊕", hl = "Function" },
      String = { icon = "󰀬", hl = "String" },
      Number = { icon = "󰎠", hl = "Number" },
      Array = { icon = "󰅪", hl = "Type" },
      Object = { icon = "󰅩", hl = "Type" },
      Key = { icon = "󰌋", hl = "" },
      Struct = { icon = "󰌗", hl = "Type" },
      Operator = { icon = "󰆕", hl = "Operator" },
      TypeParameter = { icon = "󰊄", hl = "Type" },
      StaticMethod = { icon = '󰠄 ', hl = 'Function' },
    }
  },
  -- other options ...
})

