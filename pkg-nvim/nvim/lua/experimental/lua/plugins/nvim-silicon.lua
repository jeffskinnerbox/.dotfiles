-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300


-- [Create beautiful code screenshots in Neovim. Without damaging your wrists.](https://www.youtube.com/watch?v=ig_HLrssAYE)
-- [GitHub: michaelrommel/nvim-silicon](https://github.com/michaelrommel/nvim-silicon)


return {
  'michaelrommel/nvim-silicon',
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = true,                                                                   -- 'false' means load at startup and 'true' means lazy-load this plugin and wait for an event to requires loading it, make sure that your main colorscheme is loaded first. To ensure this you can use the priority=1000 field
}
