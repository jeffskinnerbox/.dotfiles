-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/custom/plugins/trouble.lua

  Description:
    A pretty diagnostics, references, telescope results, quickfix and
    location list to help you solve all the trouble your code is causing.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :Trouble <feature>       - for list of features

    Keymapped Commands
      None that I'm using or aware of.
      <leader>Ew               - open trouble workspace diagnostics
      <leader>Ed               - open trouble document diagnostics
      <leader>Eq               - open trouble quickfix list
      <leader>El               - open trouble location list
      <leader>Et               - open todos in trouble

  Alternatives:

  Sources:
    [GitHub: folke/trouble.nvim](https://github.com/folke/trouble.nvim)
]]


return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>Ew", "<cmd>Tgouble diagnostics toggle<cr>", desc = "Open Trouble [W]orkspace Diagnostics" },
    { "<leader>Ed", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open Trouble Document [D]iagnostics" },
    { "<leader>Eq", "<cmd>Trouble quickfix toggle<cr>", desc = "Open Trouble [Q]uickfix List" },
    { "<leader>El", "<cmd>Trouble loclist toggle<cr>", desc = "Open Trouble [L]ocation List" },
    { "<leader>Et", "<cmd>Trouble todo toggle<cr>", desc = "Open ToDos in Trouble" },
  },
}
