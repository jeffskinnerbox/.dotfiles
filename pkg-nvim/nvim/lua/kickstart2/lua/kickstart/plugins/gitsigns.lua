--[[ Adds git related signs to the gutter, as well as utilities for managing Git changes
kickstart2/lua/kickstart/plugins/gitsigns.lua

  Description:
    Gitsigns is a fast plugin that adds git decorations to you file explorer.
    It also provides the Git typical functional usage, but I mainly use it for
    the Git status information it provides.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :Gitsigns show           - view the index version of the file

    Keymapped Commands
      <leader>hs               - stage the hunk at the cursor position, or all lines in the given range.
      <leader>hr               - reset the lines of the hunk at the cursor position, or all lines in the given range.
      <leader>hS               - stage all hunks in current buffer.
      <leader>hu               - undo the last call of stage_hunk()
      <leader>hR               - reset the lines of all hunks in the buffer
      <leader>hp               - preview the hunk at the cursor position in a floating window
      <leader>hb               - run git blame on the current line and show the results in a floating window
      <leader>hd               - perform a |vimdiff| on the given file against index
      <leader>hD               - perform a |vimdiff| on the given file against last commit

  Sources:
    [GitHub: lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
    [My Neovim Git Setup](https://medium.com/unixification/my-neovim-git-setup-ba918d261cb6)
    [gitsigns.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=xbbSK_2dluQ)
]]

return {
  'lewis6991/gitsigns.nvim',
  enabled = true,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to Next Git [C]hange' })
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to Previous Git [C]hange' })

      -- visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[S]tage Git Hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[R]eset Git Hunk' })

      -- normal mode
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [S]tage Hunk' }) -- stage the hunk at the cursor position, or all lines in the given range.
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [R]eset Hunk' }) -- reset the lines of the hunk at the cursor position, or all lines in the given range.
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage Buffer' }) -- stage all hunks in current buffer.
      map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[G]it [U]ndo Stage Hunk' }) -- undo the last call of stage_hunk()
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset Buffer' }) --reset the lines of all hunks in the buffer
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [P]review Hunk' }) -- preview the hunk at the cursor position in a floating window
      map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it [B]lame Line' }) -- run git blame on the current line and show the results in a floating window
      map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [D]iff Against Index' }) -- perform a |vimdiff| on the given file against index
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = 'git [D]iff Against Last Commit' }) -- perform a |vimdiff| on the given file against last commit

      -- toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Git Show [B]lame Line' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle Git Show [D]eleted' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
