--[[ a lua powered greeter like vim-startify / dashboard-nvim
kickstart2/lua/custom/plugins/alpha-nvim.lua

  Description:
    See the following alternative https://github.com/3rd/image.nvim - Bringing images to Neovim.

     apt install aview
     The-Great-Wave-Off-Kanagawa.jpg 
    
    $ identify The-Great-Wave-Off-Kanagawa.jpg
    The-Great-Wave-Off-Kanagawa.jpg JPEG 3859x2594 3859x2594+0+0 8-bit sRGB 2.24513MiB 0.000u 0:00.001

    $ identify kanagawa-logo.png 
    kanagawa-logo.png PNG 1200x1200 1200x1200+0+0 8-bit sRGB 840286B 0.000u 0:00.000

    sudo apt install jp2a
    jp2a --colors --fill --color-depth=24 --size=175x55 The-Great-Wave-Off-Kanagawa.jpg
    jp2a --colors --fill --color-depth=24 --size=130x50 kanagawa-logo.png

  Usage:
    list the most significant commandline and keymap operations
    Commandline
      :Alpha        pop-up the start screen

  Sources:
    [GitHub: goolord/alpha-nvim](https://github.com/goolord/alpha-nvim/tree/main?tab=readme-ov-file)
    [Basic Lua Neovim Configuration - Part 2](https://www.youtube.com/watch?v=cAfPmPjxRQE&t=318s)
    [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM&t=1848s)
    [vim & colors from ANSI Escape Sequences: how to display in vim the same colors that are displayed with the cat command](https://askubuntu.com/questions/172210/vim-colors-from-ansi-escape-sequences-how-to-display-in-vim-the-same-colors)
]]

return {
  'goolord/alpha-nvim',
  enabled = false,                                                              -- load the plugin if 'true' but skip completely if 'false'
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require('alpha.themes.dashboard')
    --local startify = require('alpha.themes.startify')

    -- set header
    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

--[[
    -- set header
    startify.section.header.val = {
    }
]]

    alpha.setup(dashboard.opts)
    --alpha.setup(startify.opts)
  end,
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
