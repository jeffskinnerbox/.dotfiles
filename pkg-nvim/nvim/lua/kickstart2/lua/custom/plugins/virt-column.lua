--[[ display a character or shading at the colorcolumn
kickstart2/lua/custom/plugins/virt-column.lua

  Description:
    useful to show line length limits

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: lukas-reineke/virt-column.nvim](https://github.com/lukas-reineke/virt-column.nvim)
]]


return {
  'lukas-reineke/virt-column.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  config = function()                                                           -- configuration established (i.e. callback function is called) after color scheme plugin is installed
    require('virt-column').setup()                                              -- do the setup for virt-column
    require('virt-column').overwrite {                                          -- update the default confguration to what you desire
      enabled = true,                                                           -- a valued of false will turn this feature off
      char = ' ',                                                               -- character to be used in the column
      highlight = 'StatusLineNC',                                               -- highlighting color to be used
      virtcolumn = '80',                                                        -- columns to be highlighted, list of comma seperated column numbers
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
