
--------------------------------------------------------------------------------
-- editor-enhanced/material.lua

-- Sources:
--   [GitHub: marko-cerovac/material.nvim](https://github.com/marko-cerovac/material.nvim)
--   [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, nightfox = pcall(require, "material")
if not status_ok then
  print("'configs/material.lua' module had an error")
  return
end


-- setup will over-ride the plugin's default options & features
require('material').setup({
  contrast = {
    terminal = false, -- Enable contrast for the built-in terminal
    sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = false, -- Enable contrast for floating windows
    cursor_line = false, -- Enable darker background for the cursor line
    non_current_windows = false, -- Enable darker background for non-current windows
    filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
  },
  styles = { -- Give comments, etc style such as bold, italic, underline etc.
    comments = { italic = true },
    strings = { --[[ bold = true ]] },
    keywords = { --[[ underline = true ]] },
    functions = { --[[ bold = true, undercurl = true ]] },
    variables = {},
    operators = {},
    types = {},
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    -- "dap",
    -- "dashboard",
    -- "gitsigns",
    -- "hop",
    -- "indent-blankline",
    -- "lspsaga",
    -- "mini",
    -- "neogit",
    -- "neorg",
    -- "nvim-cmp",
    -- "nvim-navic",
    -- "nvim-tree",
    -- "nvim-web-devicons",
    -- "sneak",
    -- "telescope",
    -- "trouble",
    -- "which-key",
  },
  disable = {
    colored_cursor = false,   -- disable the colored cursor
    borders = false,          -- disable borders between verticaly split windows
    background = false,       -- prevent the theme from setting the background (NeoVim then uses your terminal background)
    term_colors = false,      -- prevent the theme from setting terminal colors
    eob_lines = false         -- hide the end-of-buffer lines
  },
  high_visibility = {
    lighter = false,          -- enable higher contrast text for lighter style
    darker = false            -- enable higher contrast text for darker style
  },
  lualine_style = "default",  -- Lualine style ( can be 'stealth' or 'default' )
  async_loading = true,       -- load parts of the theme asyncronously for faster startup (turned on by default)
  custom_colors = nil,        -- if you want to everride the default colors, set this to a function
  custom_highlights = {},     -- overwrite highlights with your own
})

-- set the desired style: darker lighter, oceanic, palenight, deep ocean
vim.g.material_style = "deep ocean"

-- select color scheme
--vim.cmd("colorscheme dracula-soft")
vim.cmd("colorscheme material")

