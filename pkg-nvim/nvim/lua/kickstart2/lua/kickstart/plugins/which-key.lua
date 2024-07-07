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
            Search and Spelling        - <leader>s
            Jump to Location/File      - <leader>j
            Toggle Feature On/Off      - <leader>t
            Format/Lint/Debug Code     - <leader>c
            Documentation/Definitions  - <leader>d
            Error/Diagnostic Messages  - <leader>e
            Git Operations             - <leader>g
            Workspace/Session Mgmt.    - <leader>w

    Usage:
        Commandline
            :WhichKey                - show all key command, with or without <leader>, any mode
            :WhichKey <leader>       - show all key command, with <leader>, any mode
            :WhichKey v              - show all key command, with or without <leader>, visual mode
            :WhichKey <leader>v      - show all key command, with <leader>, visual mode
            :checkhealth which-key   - see if there's any conflicting keymaps that will prevent triggering Which-Key

        Keymapped Commands
          Which-Key is always present and will pop-up a window, assuming you type slowly,
          to aid in key selection. To see this while in Normal mode, enter
          '<leader>' key an pause to see pop-up window.

    Sources:
      [GitHub: folke/which-key.nvim](https://github.com/folke/which-key.nvim)
      [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
      [My approach to Neovim](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625)
]]

return {
  { -- Useful plugin to show you pending keybinds.
    enabled = true,
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- document top level of the key chains for 'normal' mode
      require('which-key').register {
        ['<leader>s'] = { name = '[S]earch and [S]pell', _ = 'which_key_ignore' },
        ['<leader>j'] = { name = '[J]ump to Location/File', _ = 'which_key_ignore' },
        ['<leader>c'] = { name = 'Format/Lint/Debug [C]ode', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle Feature On/Off', _ = 'which_key_ignore' },
        ['<leader>tc'] = { name = '[T]oggle [C]olor Highlighter & Picker', _ = 'which_key_ignore' },
        ['<leader>tw'] = { name = '[T]oggle Line [W]rap On/Off', _ = 'which_key_ignore' },
        ['<leader>tf'] = { name = '[T]oggle Code [F]ormatting', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument/Definitions', _ = 'which_key_ignore' },
        ['<leader>e'] = { name = '[E]rror/Diagnostic Messages', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it Operations', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace/Session Mgmt.', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]e-Name', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]elp Information', _ = 'which_key_ignore' },
      }
      -- document top level of the key chains for 'visual' mode
      require('which-key').register({
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
