-- luacheck: globals vim
-- luacheck: max line length 300

--[[ powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
kickstart2/lua/custom/plugins/comment.lua

  Description:
    This is a flexable comment plugin that I personally only used it most basic features.
    It is supported by Treesitter and automatically selects the approprate comment tag.

  Usage:
    list the most significant commandline and keymap operations. The plugin
    has keymaps enabled by default and do not use a <leader> key.

    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      Normal Mode
        gcc                      - toggles the current line using linewise comment
        gbc                      - toggles the current line using blockwise comment

      Visual Mode
        gc                       - toggles the region using linewise comment
        gb                       - toggles the region using blockwise comment

  Sources:
    [GitHub: numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
    [Comment.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=D0BLqbVg-j0)
]]


return {
  'numToStr/Comment.nvim',
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },                                       -- load the plugin when you read an existing file or new buffer is created
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('Comment').setup()
  end,
}

