-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ A plugin for automated session manager for Neovim
kickstart2/lua/custom/plugins/auto-session.lua

  Description:
    Auto Session takes advantage of Neovim's existing session management
    capabilities to provide seamless automatic session management.

    Behaviour:
    * Start nvim with no arguments, auto-session will try to restore an existing
      session (if one exists) for the current cwd.
    * Start nvim with '.; or <directory>, auto-session will try to restore
      the session for that directory.
    * Even after starting nvim with a file argument, a session can still be
      manually restored by running `:SessionRestore`.
    * Any session saving and restoration takes into consideration the current
      working directory cwd.

  Definitions:
    Project
    Workspace    FIX: add these definitions
    Session
    Session Lens - https://github.com/rmagatti/session-lens

  Usage:
    Commandline
      :SessionSave                            - saves or creates a session in the currently set `auto_session_root_dir`.
      :SessionSave ~/my/custom/path           - saves or creates a session in the specified directory path.
      :SessionRestore                         - restores a previously saved session based on the `cwd`.
      :SessionRestore ~/my/custom/path        - restores a previously saved session based on the provided path.
      :SessionRestoreFromFile ~/session/path  - restores any currently saved session
      :SessionDelete                          - deletes a session in the currently set `auto_session_root_dir`.
      :SessionDelete ~/my/custom/path         - deleetes a session based on the provided path.
      :SessionPurgeOrphaned                   - removes all orphaned sessions with no working directory left.
      :Autosession search
      :Autosession delete

    Keymapped Commands
      <leader>wr               - restore last workspace session for current directory
      <leader>ws               - save workspace session for current working directory

  Alternatives:
    [GitHub: pysan3/autosession.nvim](https://github.com/pysan3/autosession.nvim)

  Sources:
    [GitHub: rmagatti/auto-session](https://github.com/rmagatti/auto-session)

   NOTE: If there are errors in your config, restoring the session might fail. If that happens, auto session will then disable auto saving for the current session. Manually saving a session can still be done by calling `:SessionSave`.
   BUG: This plugin / configuration is not working !!
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
  "rmagatti/auto-session",
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  dependencies = {
    'nvim-telescope/telescope.nvim',                                            -- only needed if you want to use sesssion lens
  },
  config = function()
    require('auto-session').setup({
      auto_restore_enabled = false,                                             -- 'false' means that you will NOT automatically do a sesson restore
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },   -- don't save the session when in these directories
    })

    keymap("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "[W]orkspace Session [R]estore for cwd" })    -- restore last workspace session for current directory
    keymap("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "[W]orkspace Session [S]ave for cwd" })          -- save workspace session for current working directory
  end,
--[[
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },              -- don't save the session when in these directories
    })

    keymap("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "[W]orkspace Session [R]estore for cwd" })    -- restore last workspace session for current directory
    keymap("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "[W]orkspace Sessiomn [S]ave for cwd" })         -- save workspace session for current working directory
  end,
--]]
}

