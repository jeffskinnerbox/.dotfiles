-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

--[[ A plugin that dim inactive windows in Neovim using window-local highlight namespaces
kickstart2/lua/custom/plugins/tin tint.lua

  Description:
    Tint inactive windows in Neovim using window-local highlight namespaces.
   Tthis plugin will iterate over each highlight group in the active colorscheme
   when the plugin is setup and either brighten or darken each value
   (based on what you configure) for inactive windows.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Alternatives:
    [GitHub: miversen33/sunglasses.nvim](https://github.com/miversen33/sunglasses.nvim)
    [GitHub: sunjon/Shade.nvim](https://github.com/sunjon/Shade.nvim)

  Sources:
    [GitHub: levouh/tint.nvim](https://github.com/levouh/tint.nvim)
]]


return {
  "levouh/tint.nvim",
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    require("tint").setup({
      tint = -45,                                                               -- darken colors, use a positive value to brighten
      saturation = 0.6,                                                         -- saturation to preserve
      transforms = require("tint").transforms.SATURATE_TINT,                    -- showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = true,                                            -- tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },               -- highlight group patterns to ignore, see `string.find`
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
        return buftype == "terminal" or floating                                -- do not tint `terminal` or floating windows, tint everything else
      end
    })
  end,
}

