
--------------------------------------------------------------------------------
-- editor-advanced/nvim-colorizer.lua

-- Color highlighter for Neovim with no external dependencies, which means
-- you install it and it just works.

-- Commandline
--    :ColorizerToggle	       - toggle highlighting of the current buffer
--    :e $VIMRUNTIME/colors    - see the code for all the built-in color schemes
--    :highlight clear         - reset everything to the default colors

-- Sources:
--    [GitHub: NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
--    [neovimcraft: NvChad/nvim-colorizer.lua](https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua/index.html)
--    [Neovim 101 — Color Plugins](https://alpha2phi.medium.com/neovim-101-color-plugins-ea1206bc581)
--    [Neovim - Add Some Color with Colorizer](https://www.youtube.com/watch?v=Rg5ccrQ7jbc&t=71s)
--    [Neovim for Beginners — Color Scheme](https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rtn = pcall(require, "colorizer")
if not status_ok then
  print("'configs/nvim-colorizer.lua' module had an error")
  return
end


require("colorizer").setup {
  filetypes = { "*" },
  user_default_options = {
    RGB      = true,        -- #RGB hex codes - #AB1
    RRGGBB   = true,        -- #RRGGBB hex codes - #987654
    names    = true,        -- named color codes - Blue or lightblue, green, Red, yellow, black, Gray, lightgray
    RRGGBBAA = true,        -- #RRGGBBAA hex codes - #abe3829a
    AARRGGBB = true,        -- 0xAARRGGBB hex codes - 0xabe3829a
    rgb_fn   = true,        -- CSS rgb() and rgba() functions - rgb(20%,83%,15%)
    hsl_fn   = true,        -- CSS hsl() and hsla() functions
    css      = true,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
    mode = "background",    -- set the display mode - available modes for `mode`: foreground, background,  virtualtext
    -- available methods are false / true / "normal" / "lsp" / "both"
    -- true is same as normal
    tailwind = false,                                  -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { "css" }, },   -- Enable sass colors
    virtualtext = "■",
    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = true
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}

