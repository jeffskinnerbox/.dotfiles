
--------------------------------------------------------------------------------
-- editor-enhanced/comment.lua

-- Smart comment plugin for neovim. This plugin has native treesitter support
-- for determining approprate comment string which works for multiple
-- embedded languages like Vue or Markdown.
--
-- NORMAL mode
--    `gcc` - Toggles the current line using linewise comment
--    `gbc` - Toggles the current line using blockwise comment
--    `gcw` - Toggles the current word using blockwise comment
--    `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
--    `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
--
-- VISUAL mode
--    `gc` - Toggles the region using linewise comment
--    `gb` - Toggles the region using blockwise comment

-- Sources:
--   [numToStr / Comment.nvim](https://github.com/numToStr/Comment.nvim)
--   [TakeTuesday E02: Comment.nvim](https://www.youtube.com/watch?v=-InmtHhk2qM)
--   [neovimcraft: numToStr/Comment.nvim](https://neovimcraft.com/plugin/numToStr/Comment.nvim/index.html)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print("'configs/comment.lua' module had an error")
  return
end


-- setup your plugin options & features
require("Comment").setup {
    padding = false,       -- add a space between comment and the line
    sticky = true,         -- whether the cursor should stay at its position
    ignore = nil,          -- lines to be ignored while (un)comment

    -- LHS of toggle mappings in NORMAL mode
    toggler = {
        line = 'gcc',      -- line-comment toggle keymap
        block = 'gbc',     -- block-comment toggle keymap
    },

    -- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = 'gc',       -- line-comment keymap
        block = 'gb',      -- block-comment keymap
    },

    -- LHS of extra mappings
    extra = {
        above = 'gcO',     -- add comment on the line above
        below = 'gco',     -- add comment on the line below
        eol = 'gcA',       -- add comment at the end of line
    },

    -- enable keybindings
    -- NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        basic = true,      -- operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        extra = true,      -- extra mapping; `gco`, `gcO`, `gcA`
    },

    pre_hook = nil,        -- function to call before (un)comment
    post_hook = nil,       -- function to call after (un)comment
}

