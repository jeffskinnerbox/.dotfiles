-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ plugin to configure status line at the bottom of the buffer
  kickstart2/lua/custom/plugins/lualine.lua

  Description:
    Plugin for neovim status bar at the bottom of the screen. It is useful for
    showing neovim mode state, cursor location, file type, etc.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim/tree/master)
    [Custom Neovim Statusline](https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html)
    [How I Made My NeoVim Statusline in Lua](https://elianiva.my.id/posts/neovim-lua-statusline/)
]]


return {
  'nvim-lualine/lualine.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  --dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
  dependencies = { 'nvim-tree/nvim-web-devicons', 'rebelot/kanagawa.nvim' },
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    options = { theme = 'MyColorScheme' }
    require('lualine').setup {
      sections = {
        lualine_c = {                                                           -- show the absolute path for the file name
          {
            'filename',
            file_status = true,                                                 -- Displays file status (readonly status, modified status)
            newfile_status = false,                                             -- Display new file status (new file means no write after created)
            path = 3,                                                           -- 0: Just the filename, 1: Relative path, 2: Absolute path, 3: Absolute path, with tilde as the home directory, 4: Filename and parent dir, with tilde as the home directory
            shorting_target = 40,                                               -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = '[+]',                                                 -- Text to show when the file is modified.
              readonly = '[-]',                                                 -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]',                                            -- Text to show for unnamed buffers.
              newfile = '[New_File]',                                           -- Text to show for newly created file before first write
            },
          },
        },
      },
    }
  end,
}

