-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin to provide tab-line on top of screen (useful when editing multiple files)
kickstart2/lua/custom/plugins/bufferline.lua

  Description:
     This is an attractive, informative, and easy to navigate tab-line tool,
     located at the top of the buffer, which makes use of Nerd Fonts.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
    [Neovim - Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)
    [You don’t need tabs in Neovim](https://medium.com/@jogarcia/you-dont-need-tabs-in-neovim-c6ba5ee44e3e)
]]


return {
  'akinsho/bufferline.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  version = '*',                                                                -- version to use from the github repository, '*' means any version, full Semver ranges are supported
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    vim.opt.termguicolors = true
    require('bufferline').setup()
  end,
}

