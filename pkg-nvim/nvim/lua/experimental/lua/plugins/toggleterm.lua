-- luacheck: globals vim _LAZYGIT_TOGGLE _NODE_TOGGLE _PYTHON_TOGGLE _HTOP_TOGGLE _NCDU_TOGGLE
-- luacheck: max line length 300

--[[ A plugin to easily persist and toggle multiple terminals
kickstart2/lua/custom/plugins/toggleterm.lua

  Description:
    This is a NeoVim plugin to persist and toggle multiple terminals during
    an editing session. It helps easily manage these multiple terminal windows
    that are oriented vertically, horizontally, floating, or embedded within tabs.
    Its a wrapper around the NeoVim's native terminal functionality.

    Why a terminal emulator in NeoVim? You may want to set a process going
    and leave it to continue to run in the background. Maybe you don't need
    to see it all the time. Sometimes I want these side by side,
    and I really want these terminals to be easy to access.
    Also, you may want the terminal to look different from non-terminal buffers,
    so you can use `winhighlight` to darken them based on the Normal background color.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop
      :ToggleTermToggleAll     - open or close all the previously toggled terminal
      :2TermExec cmd="git status" dir=~/<my-repo-path>   - open a terminal with a specific action in terminal 2

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Alternatives:

  Sources:
    [GitHub: akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
    [Terminal Support in NeoVim](https://medium.com/@shaikzahid0713/terminal-support-in-neovim-c616923e0431)
    [ToggleTerm Plugin in Neovim](https://www.youtube.com/watch?v=TTNErF0CXmc)

   NOTE: list anything worth noting
   BUG: list any known bugs
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
  'akinsho/toggleterm.nvim',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  version = "*",
  config = function()
    require('toggleterm').setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
        border = "Normal",
        background = "Normal",
        },
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()                                                          -- within a shell, execute the command 'lazygit'
    end

    local node = Terminal:new({ cmd = "node", hidden = true })
    function _NODE_TOGGLE()                                                     -- within a shell, execute the command 'node'
      node:toggle()
    end

    local python = Terminal:new({ cmd = "python3", hidden = true })
    function _PYTHON_TOGGLE()
      python:toggle()                                                           -- within a shell, execute the command 'python3'

    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })
    function _HTOP_TOGGLE()
      htop:toggle()                                                             -- within a shell, execute the command 'htop'
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
    function _NCDU_TOGGLE()
      ncdu:toggle()                                                             -- within a shell, execute the command 'ncdu'
    end

    -- define the keymapping for a terminal window
    function _G.set_terminal_keymaps()
      local opts = {noremap = true}
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")            -- set the keymaps for the terminal window when its opened

    keymap('n', '<leader>tl',  "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "[L]azyGit Terminal" })          -- LazyGit Terminal
    keymap('n', '<leader>tn',  "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "[N]ode Terminal" })                -- NodeJS Terminal
    keymap('n', '<leader>tp', "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "[P]ython Terminal" })             -- Python Terminal
    keymap('n', '<leader>th', "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "[H]top Terminal" })                 -- Htop Terminal
    keymap('n', '<leader>td', "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "NCurses [D]isk Usage Terminal" })   -- NCurses Disk Usage Terminal
    keymap('n', '<leader>tf', "<cmd>ToggleTerm direction=float<cr>", { desc = "[F]loat Terminal" })        -- Floating Terminal
  end
}
