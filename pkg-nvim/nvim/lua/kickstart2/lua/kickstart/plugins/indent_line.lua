--[[ Add indentation guides even on blank lines
kickstart2/lua/kickstart/plugins/indent_line.lua

  Description:
    describe what this plugin does

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

   NOTE: list anything worth noting 
   BUG: list any known bugs
]]

return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true, -- load the plugin if 'true' but skip completely if 'false'
  main = 'ibl', -- see `:help ibl`
  opts = {},
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
