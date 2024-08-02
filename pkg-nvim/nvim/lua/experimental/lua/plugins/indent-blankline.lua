-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin adds indentation guides to Neovim
kickstart2/lua/kickstart/plugins/indent_line.lua

  Description:
    This plugin adds indentation guides to Neovim. It uses Neovim's
    virtual text feature and no conceal. To start using indent-blankline,
    call the `ibl.setup()` function or `opts = { ... }`.

  Usage:

    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
    [indent-blankline - Weekly Neovim Plugin](https://www.youtube.com/watch?v=4iPiYljl2RY)
]]

return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  main = 'ibl',                                                                 -- see `:help ibl`
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
  },
}

