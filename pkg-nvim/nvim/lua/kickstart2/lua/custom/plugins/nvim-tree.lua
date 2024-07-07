--[[ A file explorer tree for neovim written in lua

  Description:
    NeoVimTree is a file system navigator for NeoVim written in lua.  Its a Lua
    alternative to NerdTree and Vim's native navigator netrw.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :NvimTreeToggle       -  open or close the tree
      :NvimTreeFocus        -  open the tree if it is closed, and then focus on the tree
      :NvimTreeFindFile     -  move the cursor in the tree for the current buffer, opening folders if needed
      :NvimTreeCollapse     -  collapses the nvim-tree recursively

    Mapped Key Commands
      <leader>te            - open or close the explorer tree window (same as :NvimTreeToggle)

    Working Within File Explorer
      Operations
        H                   - hide - toggle hide/display hidden files/folders
        E                   - expand all - expand the entire file tree starting from the root folder
        W                   - collapse all - close all open folders starting from the root folder
        Ctrl+]              - change the root of the nvim-tree, and the current working directory, to the selected directory

      File Management
        a                   - add a file to the filesystem at the selected directory
        a                   - add a directory to the filesystem by following the name with the slash /
        o                   - open a file and stay in file explorer
        c                   - copy - copies the file to the clipboard but keeps the original file in its location
        p                   - paste - paste the contents of the clipboard to the current location
        r                   - rename - rename the file or directory
        d                   - delete - to delete file or directory

  Sources:
    [Github: nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
    [Migrate from NerdTree to NvimTree](https://taoshu.in/vim/migrate-nerdtree-to-nvim-tree.html)
    [File Explorer for Neovim](https://medium.com/@shaikzahid0713/file-explorer-for-neovim-c324d2c53657)
    [Neovim - NvimTree File Explorer Written In Lua](https://www.youtube.com/watch?v=SpexCBrZ1pQ)
    [GitHub: LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch/blob/12-nvimtree/lua/user/nvim-tree.lua)

    NOTE: Disable 'netrw' entirely if your using 'nvim-tree.lua' plugin as a replacement for the native 'netrw'.
    NOTE: Disable 'netrw' at the very start of your 'init.lua' (strongly advised), see your 'options.lua' file on how to do this.
]]

return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  version = '*',                                                                -- version to use from the github repository, '*' means any version, full Semver ranges are supported
  lazy = false,                                                                 -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()                                                           -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    require('nvim-tree').setup {
      sort = { sorter = 'case_sensitive' },
      view = { width = 30 }, -- width of the nvim-tree side panel
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    }

    -- custom key mappings
    vim.keymap.set('n', '<leader>te', '<cmd>NvimTreeToggle><cr>', { desc = 'Toggle On/Off File Explorer' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
