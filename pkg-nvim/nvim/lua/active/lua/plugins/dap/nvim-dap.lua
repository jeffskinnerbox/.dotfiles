-- luacheck: globals vim
-- luacheck: max line length 300

--[[ nvim-dap is a Debug Adapter Protocol (DAP) client to debug your code

  Description:
    nvim-dap is a Debug Adapter Protocol (DAP) client implementation for Neovim.
    nvim-dap allows you to:

      * Launch an application to debug
      * Attach to running applications and debug them
      * Set breakpoints and step through code
      * Inspect the state of the application

    Shows how to use the DAP plugin to debug your code. Primarily focused on
    configuring the debugger for Go, but can be extended to other languages
    as well.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
    [How to configure Debuggers in Neovim](https://www.youtube.com/watch?v=oYzZxi3SSnM)

    Check these output
    [GitHub: andrewferrier/debugprint.nvim](https://github.com/andrewferrier/debugprint.nvim)
    [Neovim for Beginners — Print Debugging](https://alpha2phi.medium.com/neovim-for-beginners-print-debugging-53d131abd396)
    [Neovim for Beginners — Refactoring](https://alpha2phi.medium.com/neovim-for-beginners-refactoring-4f517d12a43f)
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
  'mfussenegger/nvim-dap',                                                      -- dap client for neovim
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  dependencies = {
    'williamboman/mason.nvim',                                                  -- plugin manager for easily install of DAP servers
    'rcarriga/nvim-dap-ui',                                                     -- creates a beautiful debugger UI
    'nvim-neotest/nvim-nio',                                                    -- library for asynchronous IO in Neovim for nvim-dap-ui
    'jay-babu/mason-nvim-dap.nvim',                                             -- bridges mason.nvim with the nvim-dap plugin making it easier to use both plugins together
    'leoluz/nvim-dap-go',                                                       -- extension for nvim-dap providing configurations for launching go debugger
    --'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    require('mason-nvim-dap').setup {
      automatic_installation = true,                                            -- makes a best effort to setup the various debuggers with reasonable debug configurations
      handlers = {},                                                            -- you can provide additional configuration to the handlers, see mason-nvim-dap README for more information

      -- you'll need to check that you have the required things installed
      ensure_installed = {                                                      -- update this to ensure that you have the debuggers for the langs you want
        'delve',                                                                -- go debugger
      },
    }

    -- basic debugging keymaps, feel free to change to your liking!
    keymap('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    keymap('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    keymap('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    keymap('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    keymap('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })   -- toggle to see last session result, without this, you can't see session output in case of unhandled exception.
    keymap('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    keymap('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })

    -- dap UI setup, for more information, see :help nvim-dap-ui
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },         -- set icons to characters that are more likely to work in every terminal.
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- install golang specific config
    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'win32' == 0,                                     -- on Windows delve must be run attached or it crashes, See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      },
    }
  end,
}

