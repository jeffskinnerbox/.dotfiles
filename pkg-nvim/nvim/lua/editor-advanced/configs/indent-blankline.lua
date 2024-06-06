
--------------------------------------------------------------------------------
-- editor-advanced/indent-blankline.lua

-- This plugin adds indentation guide lines to all the line indents,
-- including empty lines.

-- NOTE: I have disabled indent-blankline's ability to show hidden characters at start-up
-- but this can be toggled on/off via a key-mapping '<leader>hc' in keymappings.lua

-- Sources:
--    [GitHub: lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
--    [indent-blankline - Weekly Neovim Plugin](https://www.youtube.com/watch?v=4iPiYljl2RY)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, rnt = pcall(require, "indent_blankline")
if not status_ok then
  print("'configs/indent-blankline.lua' module had an error")
  return
end


vim.opt.list = false                    -- if set to 'true'to show hidden characters (e.g. space, tab, eol, cr, etc.)
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-- setup your plugin options & features
require("ibl").setup { indent = { highlight = highlight } }

