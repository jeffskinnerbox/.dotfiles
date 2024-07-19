-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/kickstart/plugins/which-key.lua

    Description:
      Nobody is going to remember all the key bindings available in Neovim.
      Which-Key is a lua plugin that displays a pop-up with possible key bindings
      of the command you started typing.

      The key mapping configuration needs to be minimal, so I can focus more
      on the editing itself, without thinking much about any plugin or module used.
      Some of (maybe all) of the native commands should not be remapped but
      the command that come with plugins & modules will likely require some reorganization.

      While in my editor, I want to search for something, deal with spelling or grammar,
      goto/jump to a location/file, format/lint/debug code, make text edits
      like add/delete/modify/move in some why, toggle some feature on/off,
      review definitions or documentation, review error/diagnostic messages,
      sourced code operations via Git, workspace/session management.

      I'm organizing my key mappings in these large 'key' buckets:
            Search and Spelling                - <leader>s
            Jump to Location/File              - <leader>j
            Tab Management                     - <leader>t
            Toggle Feature On/Off              - <leader>T
            Format/Lint/Debug Code             - <leader>c      FIX: needs to be updated
            Documentation/Definitions          - <leader>d
            Error/Diagnostic/Troubles          - <leader>E
            Filesystem Explorer                - <leader>e
            Git [H]unk Operations / LazyGit    - <leader>h
            Workspace/Session Mgmt.            - <leader>w
            Format                             - <leader>F

  Definitions:
    Definitions of phrases when it could be helpful.

    Usage:
        Commandline
            :WhichKey                  - show all key command, with or without <leader>, any mode
            :WhichKey <leader>         - show all key command, with <leader>, any mode
            :WhichKey v                - show all key command, with or without <leader>, visual mode
            :WhichKey <leader>v        - show all key command, with <leader>, visual mode
            :checkhealth which-key     - see if there's any conflicting keymaps that will prevent triggering Which-Key

        Keymapped Commanns
          Which-Key is always present and will pop-up a window, assuming you type slowly,
          to aid in key selection. To see this while in Normal mode, enter
          '<leader>' key an pause to see pop-up window.

  Alternatives:
      [GitHub: mrjones2014/legendary.nvim](https://github.com/mrjones2014/legendary.nvim)

    Sources:
      [GitHub: folke/which-key.nvim](https://github.com/folke/which-key.nvim)
      [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
      [My approach to Neovim](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625)
]]

return {
  'folke/which-key.nvim',
  enabled = true,
  event = 'VeryLazy',                                                           -- sets the plugin loading event to 'VeryLaza
  --opts.icons.rules = false,
  opts = {
    icons = {                                                                   -- BUG: problem could be which-key.nvim v3 was just released! - https://www.reddit.com/r/neovim/comments/1e1q0px/whichkeynvim_v3_was_just_released/
      mappings = false,                                                         -- BUG: doesn't see to work - set to 'false' to disable all mapping icons, both those explicitely added in a mapping and those from rules, check how your using which-key since it may be the issue
      rules = { false, },
    },
  },
  init = function()                                                             -- this function runs at nvim startup, that is, before plugin is loaded
    vim.opt.timeout = true                                                      -- if true, a popup window will be fired
    vim.opt.timeoutlen = 300                                                    -- how long (in milliseconds) which-key will what before doing the popup window
  end,

  config = function()                                                           -- this function runs AFTER plugin is loaded
    require('which-key').setup()

--[[
    -- for 'normal' mode - document top level of the key chains
    require('which-key').register({
      ['<leader>c'] = { name = 'Format/Lint/Debug [C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument/Definitions', _ = 'which_key_ignore' },
      ['<leader>e'] = { name = 'Filesystem Explorer', _ = 'which_key_ignore' },
      ['<leader>E'] = { name = '[E]rror/Diagnostic/Troubles', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]ind Files, Words, etc.', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it Operations', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]elp Information', _ = 'which_key_ignore' },
      ['<leader>j'] = { name = '[J]ump to Location/File', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]eName', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]plit Management and [S]pell', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]ab Management', _ = 'which_key_ignore' },
      ['<leader>T'] = { name = '[T]oggle Feature On/Off', _ = 'which_key_ignore' },
      ['<leader>Tc'] = { name = '[T]oggle [C]olor Highlighter & Picker', _ = 'which_key_ignore' },
      ['<leader>Tf'] = { name = '[T]oggle Code [F]ormatting', _ = 'which_key_ignore' },
      ['<leader>Tw'] = { name = '[T]oggle Line [W]rap On/Off', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace/Session Mgmt.', _ = 'which_key_ignore' },
    })
]]
    require('which-key').add({                                                  -- for 'normal' mode - document top level of the key chains
      { "<leader>a", group = "[B]uffer Management" },
      { "<leader>c", group = "Format/Lint/Debug [C]ode" },
      { "<leader>d", group = "[D]ocument/Definitions" },
      { "<leader>e", group = "Filesystem [E]xplorer" },
      { "<leader>E", group = "[E]rror/Diagnostic/Troubles" },
      { "<leader>f", group = "[F]ind Files, Words, etc." },
      { "<leader>h", group = "Git [H]unk Operations / LazyGit" },
      { "<leader>j", group = "[J]ump to Location/File" },
      { "<leader>r", group = "[R]eName" },
      { "<leader>s", group = "[S]plit Management and [S]pell" },
      { "<leader>t", group = "[T]erminal Management" },
      { "<leader>T", group = "[T]oggle Feature On/Off" },
      { "<leader>Tc", group = "[T]oggle [C]olor Highlighter & Picker" },
      { "<leader>Tf", group = "[T]oggle Code [F]ormatting" },
      { "<leader>Tw", group = "[T]oggle Line [W]rap On/Off" },
      { "<leader>w", group = "[W]orkspace/Session/Window Mgmt." },
    })

    require('which-key').add({                                                  -- for 'visual' mode - document top level of the key chains
      { "<leader>h", desc = "Git [H]unk", mode = "v" },
    })
  end,
}
