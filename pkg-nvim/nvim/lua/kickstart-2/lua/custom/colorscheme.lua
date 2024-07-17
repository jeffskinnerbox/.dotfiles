-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[
kickstart2/lua/custom/colorscheme.lua

  Description:
    This is where you set the color scheme for the entire NeoVim envirnment.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :colorscheme <name>                  - activate the <name> color scheme
      :e $VIMRUNTIME/colors                - takes you to color code for all the NeoVim built-in color schemes
      :so $VIMRUNTIME/syntax/hitest.vim    - see all the current active highlight groups
      :Telescope highlights                - see and search for the highlight groups
      :$VIMRUNTIME/syntax                  - see the syntax definitions and the highlight group definitions for all NeoVim natively supported languages

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [Neovim for Beginners — Color Scheme](https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6)
    [Neovim - Colorschemes and how to set them](https://www.youtube.com/watch?v=RtNPfJKNr_8)
    [The BEST Neovim color themes; some with support for Terminals and the latest Lua](https://www.youtube.com/watch?v=_evGrg4l3C)
]]


-- global variables used to set neovim color scheme, recommended values are:
--     'kanagawa-dragon', 'kanagawa-wave', 'kanagawa-lotus'
--     'tokyonight-night', 'tokyonight-storm', 'tokyonight-day', 'tokyonight-moon'
--     'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-macchiato', 'catppuccin-mocha'
MyColorScheme = 'kanagawa-dragon'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. MyColorScheme)
if not status_ok then
  vim.notify("color scheme called '" .. MyColorScheme .. "' not found!  Using 'default' instead.")
  MyColorScheme = 'default'
end

vim.cmd.colorscheme(MyColorScheme)                                              -- set the neovim color scheme

