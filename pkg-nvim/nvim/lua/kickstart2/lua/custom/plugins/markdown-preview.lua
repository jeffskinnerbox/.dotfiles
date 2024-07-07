--[[ preview markdown files on your modern browser with synchronised scrolling and fast updates

  Description:
    Preview Markdown in your modern browser with synchronised scrolling
    and flexible configuration.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :MarkdownPreview
      :MarkdownPreviewStop
      :MarkdownPreviewToggle

  Sources:
    [GitHub: iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
]]

return {
  'iamcco/markdown-preview.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
