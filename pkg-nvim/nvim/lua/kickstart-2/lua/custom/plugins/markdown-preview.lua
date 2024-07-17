-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

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
    [Problem Installing Markdown Preview for LazyVim](https://www.reddit.com/r/neovim/comments/11duwq3/problem_installing_markdown_preview_for_lazyvim/)
]]


-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    options                                                                     -- aka {opts}, keymap options
  )
end


return {
  'iamcco/markdown-preview.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  config = function()
    keymap('n', '<leader>fm', '<cmd>MarkdownPreview<cr>', { desc = '[F]ormat [M]arkdown File in Browser' })  -- stage the hunk at the cursor position, or all lines in the given range.
  end,
  ft = { 'markdown' },
}

