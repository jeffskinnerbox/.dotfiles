-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ Highly experimental plugin that completely replaces the UI for messages, cmdline, and the popup-menu.
kickstart2/lua/custom/plugins/noic.lua

  Description:
    describe what this plugin does

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
    [GitHub: folke/noice.nvim](https://github.com/folke/noice.nvim)
    [noice.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=nbfVycNhXsk)
    [Neovim & Lazy - Experimental noice.nvim plugin](https://www.youtube.com/watch?v=mwBhouHhp4c)
    [The Most Requested Neovim Configuration](https://levelup.gitconnected.com/the-most-requested-neovim-configuration-33a8fc4eed56)
    [The Most Requested Neovim Config](https://www.youtube.com/watch?v=upM6FOtdLeU)
]]

return {
  'folke/noice.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {                                                              -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',                                                     -- OPTIONAL: `nvim-notify` is only needed, if you want to use the notification view, if not available, we use `mini` as the fallback
  },
}

