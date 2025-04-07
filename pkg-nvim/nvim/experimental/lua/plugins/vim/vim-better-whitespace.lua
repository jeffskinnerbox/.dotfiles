-- luacheck: max line length 300

--[[ plugin highlights trailing whitespace characters and removes them when buffer is saved

  Description:
    This plugin causes all trailing whitespace characters to be highlighted.
    Whitespace for the current line will not be highlighted while in insert mode.
    It is possible to disable current line highlighting while in other modes
    as well (see options below). A helper functions are also provided to make
    whitespace cleaning painless.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :EnableWhitespace               - enable whitespace highlighting
      :DisableWhitespace              - disable whitespace highlighting
      :ToggleWhitespace               - toggle on/off whitespace highlighting
      :EnableStripWhitespaceOnSave    - enable striping whitespace on save
      :DisableStripWhitespaceOnSave   - disable striping whitespace on save
      :ToggleStripWhitespaceOnSave    - toggle on/off striping whitespace on save
      :StripWhitespace                - strip whitespace now, don't wait for buffer to be saved

    Keymapped Commands
      none that I'm using or aware of

  Alternatives:
      bronson/vim-trailing-whitespace

  Sources:
    [GitHub: ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
    [Show Trailing Whitespace in Markdown Files with vim-better-whitespace](https://www.youtube.com/watch?v=IRRVec5MvpY)
    [Script Roundup: Better Whitespace, vim-stdtabs](https://medium.com/usevim/script-roundup-better-whitespace-vim-stdtabs-cf589bb9f1b2)
]]--


return {
  'ntpeters/vim-better-whitespace',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = { "BufReadPre", "BufNewFile" },                                       -- load the plugin when you read an existing file or new buffer is created
  config = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = "#800000" })               -- at startup set the whitespace highlight color so trailing whitespace becomes visible
    vim.cmd('EnableWhitespace')                                                 -- at startup enable highlighting trailing whitespace for all file
    vim.cmd('EnableStripWhitespaceOnSave')                                      -- at startup enable enable stripping trailing whitespace for all file
  end,
}

