-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ To open the URL under your cursor, you can just press 'gx'.
kickstart2/lua/custom/plugins/url-open.lua

  Description:
    describe what this plugin does

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline:
      :URLOpenUnderCursor          Open url under cursor
      :URLOpenHighlightAll         Highlight all url in current buffer
      :URLOpenHighlightAllClear    Clear all highlight url in current buffer

  Sources:
    [Open URL under cursor](https://vimtricks.com/p/open-url-under-cursor/)
    [GitHub: sontungexpt/url-open](https://github.com/sontungexpt/url-open)

  BUG:Use with the mouse cause thing to break.  I'm just going to start using 'gx' keymapping, a NeoVim native command
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
  'sontungexpt/url-open',
  enabled = false,                                                              -- load the plugin if 'true' but skip completely if 'false'
  event = 'VeryLazy',
  cmd = 'URLOpenUnderCursor',
  config = function()
    local status_ok, url_open = pcall(require, 'url-open')
    if not status_ok then
      return
    end
    url_open.setup {
      open_only_when_cursor_on_url = false,                                     -- if true, only open the URL when the cursor is in the middle of the URL, if false, open the next URL found from the cursor position, which means you can open a URL even when the cursor is in front of the URL or in the middle of the URL
      highlight_url = {
        all_urls = {
          enabled = false,
          fg = '#21d5ff',                                                       -- "text" or "#rrggbb"
          -- fg = "text",                                                       -- text will set underline same color with text
          bg = nil,                                                             -- nil or "#rrggbb"
          underline = true,
        },
        cursor_move = {
          enabled = true,
          fg = '#199eff',                                                       -- "text" or "#rrggbb"
          -- fg = "text",                                                       -- text will set underline same color with text
          bg = nil,                                                             -- nil or "#rrggbb"
          underline = true,
        },
      },
    }

    -- mouse selection of a url
    keymap('n', '<leftmouse>', '<esc><cmd>URLOpenUnderCursor<cr>', { desc = 'goto to URL', noremap = true, silent = true })    -- for mouse selection
    --vim.keymap.set('n', 'gx', '<esc><cmd>URLOpenUnderCursor<cr>', { desc = 'goto to URL' })                                  -- for key selection (this will override neovim's native 'gx' keymap which does the same thing)
  end,
}

