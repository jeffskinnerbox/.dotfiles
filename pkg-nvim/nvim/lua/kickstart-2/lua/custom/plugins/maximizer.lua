-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ A plugin that maximize and restore the current window
kickstart2/lua/custom/plugins/maximizer.lua

  Description:
    Maximize and restore the current window in Neovim.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.
      <leader>tw               - toggle window size
      <leader>wm               - maximize window size
      <leader>wr               - resore window size

  Alternatives:

  Sources:
    [GitHub: 0x00-ketsu/maximizer.nvim](https://github.com/0x00-ketsu/maximizer.nvim)
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
  "0x00-ketsu/maximizer.nvim",
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  config = function()
    require("maximizer").setup({
      -- your configuration comes here or leave it empty to use the default settings, refer to the configuration section https://github.com/0x00-ketsu/maximizer.nvim
    })
    keymap('n', '<leader>Tws', '<cmd>lua require("maximizer").toggle()<CR>', { desc = '[T]oogle Current [W]indow [S]ize' })
    --keymap('n', '<leader>wm', '<cmd>lua require("maximizer").maximize()<CR>', { desc = '[W]indow [M]aximum Size' })
    --keymap('n', '<leader>wR', '<cmd>lua require("maximizer").restore()<CR>', { desc = '[W]indow [R]estore Size' })
  end,
}

