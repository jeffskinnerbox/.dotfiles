--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/custom/plugins/nvim-colorizer.lua

  Description:
   Color highlighter for Neovim with no external dependencies, which means
   you install it and it just works.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :ColorizerToggle	       - toggle highlighting of the current buffer
      :e $VIMRUNTIME/colors    - see the code for all the built-in color schemes
      :highlight clear         - reset everything to the default colors

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
    [neovimcraft: NvChad/nvim-colorizer.lua](https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua/index.html)
    [Neovim 101 — Color Plugins](https://alpha2phi.medium.com/neovim-101-color-plugins-ea1206bc581)
    [Neovim - Add Some Color with Colorizer](https://www.youtube.com/watch?v=Rg5ccrQ7jbc&t=71s)
    [Neovim for Beginners — Color Scheme](https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6)
]]


return {
  'norcalli/nvim-colorizer.lua',
  enabled = false,                                                              -- load the plugin if 'true' but skip completely if 'false'
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    require('colorizer').setup {
      filetypes = { '*' },
      user_default_options = {
        RGB = true,                                                             -- #RGB hex codes - #AB1
        RRGGBB = true,                                                          -- #RRGGBB hex codes - #987654
        names = true,                                                           -- named color codes - Blue or lightblue, green, Red, yellow, black, Gray, lightgray
        RRGGBBAA = true,                                                        -- #RRGGBBAA hex codes - #abe3829a
        AARRGGBB = true,                                                        -- 0xAARRGGBB hex codes - 0xabe3829a
        rgb_fn = true,                                                          -- CSS rgb() and rgba() functions - rgb(20%,83%,15%)
        hsl_fn = true,                                                          -- CSS hsl() and hsla() functions
        css = true,                                                             -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,                                                          -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = 'background',                                                    -- set the display mode - available modes for `mode`: foreground, background,  virtualtext
        tailwind = false,                                                       -- enable tailwind colors, available methods are false / true / "normal" / "lsp" / "both", true is same as normal
        sass = { enable = false, parsers = { 'css' } },                         -- enable sass colors, parsers can contain values used in |user_default_options|
        virtualtext = '■',
        always_update = true,                                                   -- update color values even if buffer is not focused, example use: cmp_menu, cmp_docs
      },
      buftypes = {},                                                            -- all the sub-options of filetypes apply to buftypes
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
