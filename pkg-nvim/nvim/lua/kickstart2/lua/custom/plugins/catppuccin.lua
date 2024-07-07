--[[ soothing pastel color scheme for neovim
kickstart2/lua/custom/plugins/catppuccin.lua

  Description:
    describe what this plugin does

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: catppuccin/nvim](https://github.com/catppuccin/nvim/)
]]

return {
  'catppuccin/nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = false,                                                                 -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
  name = 'catppuccin',
  priority = 1000,                                                              -- make sure to load this before all the other start plugins
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    require('catppuccin').setup {                                               -- setup will over-ride the plugin's default options & features
      flavour = 'auto',                                                         -- latte, frappe, macchiato, mocha
      background = {                                                            -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false,                                           -- disables setting the background color
      show_end_of_buffer = false,                                               -- shows the '~' characters after the end of buffers
      term_colors = false,                                                      -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,                                                        -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,                                                      -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,                                                        -- force no italic
      no_bold = false,                                                          -- force no bold
      no_underline = false,                                                     -- force no underline
      styles = {                                                                -- handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },                                                -- change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        --miscs = {},                                                           -- uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        -- for more plugins integrations goto https://github.com/catppuccin/nvim#integrations
      },
    }
    --vim.cmd.colorscheme 'catppuccin-mocha'                                    -- select color scheme from 'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-macchiato', 'catppuccin-mocha', setup() must be called before setting colorscheme
  end,
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
