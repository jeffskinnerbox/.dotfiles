-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin that i fast and fully programmable greeter for neovim

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

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    Commandline
      :Alpha        pop-up the start screen

  Alternatives:
    [GitHub: mhinz/vim-startify](https://github.com/mhinz/vim-startify)
    [GitHub: nvimdev/dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)

  Sources:
    [GitHub: goolord/alpha-nvim](https://github.com/goolord/alpha-nvim/tree/main?tab=readme-ov-file)
    [Basic Lua Neovim Configuration - Part 2](https://www.youtube.com/watch?v=cAfPmPjxRQE&t=318s)
    [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM&t=1848s)
    [vim & colors from ANSI Escape Sequences: how to display in vim the same colors that are displayed with the cat command](https://askubuntu.com/questions/172210/vim-colors-from-ansi-escape-sequences-how-to-display-in-vim-the-same-colors)
]]


return {
  'goolord/alpha-nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')                         -- alternative is "local startify = require('alpha.themes.startify')"

    -- set header for dashboard
    local logo = [[


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

    ]]
    dashboard.section.header.val = vim.split(logo, '\n')

    -- setup menu to be displayed on dashboard under header
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<cr>"),
      dashboard.button(vim.g.mapleader .. "ee", "  > Toggle File Explorer", "<cmd>NvimTreeToggle<cr>"),
      dashboard.button(vim.g.mapleader .. "ff", "󰱼  > Find File", "<cmd>Telescope find_files<cr>"),
      dashboard.button(vim.g.mapleader .. "fs", "  > Find Word", "<cmd>Telescope live_grep<cr>"),
      dashboard.button(vim.g.mapleader .. "wr", "󰁯  > Restore Session For CWD", "<cmd>SessionRestore<cr>"),
      dashboard.button("q", "  > Quit NeoVim", "<cmd>qa<cr>"),
    }

    alpha.setup(dashboard.opts)                                                 -- send configuration to alpha, alternative is "alpha.setup(startify.opts)"
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])                   -- disable folding on the alpha buffer
  end,
}

