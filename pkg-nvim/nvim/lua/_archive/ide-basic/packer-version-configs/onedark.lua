
--------------------------------------------------------------------------------
-- ide-basic/onedark.lua

-- Eight theme styles (One Dark + 5 variants) and (One Light + 1 variant)
-- for NeoVim written in lua with TreeSitter syntax highlight. You can customize
-- colors, highlights and code style of the theme as you like, and toggle
-- the theme style without exiting Neovim.

-- You can control theme style with:
--    <leader>ts           - used to toggle the theme style through all eight optons

-- Sources:
--    [GitHub: navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)
--    [NvChad/nvim-colorizer.lua](https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua/index.html)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  print("'configs/onedark.lua' module had an error")
  return
end


-- default configuration
require('onedark').setup {
    -- main options
    style = 'dark',                     -- default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,                -- show/hide background
    term_colors = true,                 -- change terminal color as per the selected theme style
    ending_tildes = false,              -- show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false,       -- reverse item kind highlights in cmp menu

    -- toggle theme style
    toggle_style_key = "<leader>ts",    -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options
    lualine = {
        transparent = false,            -- lualine center bar transparency
    },

    -- Custom Highlights
    colors = {},                        -- override default colors
    highlights = {},                    -- override highlight groups

    -- Plugins Config
    diagnostics = {
        darker = true,                  -- darker colors for diagnostic
        undercurl = true,               -- use undercurl instead of underline for diagnostics
        background = true,              -- use background color for virtual text
    },
}

-- enable theme
require('onedark').load()

