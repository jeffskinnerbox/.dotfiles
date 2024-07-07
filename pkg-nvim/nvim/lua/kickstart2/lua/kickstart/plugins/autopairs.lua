--[[ autopairs for neovim written in lua, supporting multiple characters
kickstart2/lua/kickstart/plugins/autopairs.lua

  Description:
    Auto-Pairs automatically completes the closed brace of any pair such as {} ,(), [].
    What it does is a simple task but provies to be useful since completing braces
    is a task perfrom many times when writing code.

  Usage:
    Commandline
      None that I'm using or aware of.

    Mapped Key Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
    [Auto Pairs for Neovim](https://medium.com/@shaikzahid0713/auto-pairs-for-neovim-60f20ae94387)
]]

return {
  'windwp/nvim-autopairs',
  enabled = true,
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },                                        -- optional dependency
  config = true,
  opts = {},                                                                    -- use opts = {} for passing setup options, this is equalent to setup({}) function
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
