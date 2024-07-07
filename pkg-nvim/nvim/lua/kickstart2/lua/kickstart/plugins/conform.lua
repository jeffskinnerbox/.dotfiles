--[[ Lightweight yet powerful formatter plugin for Neovim
kickstart2/doc/lua-file-template.lua

  Description:
    This is is a lightweight, yet powerful, formatter plugin for Neovim.
    It is a good alternative to null-ls.nvim in terms of formatting.

  Usage:
    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
    [How To Setup Linting & Formatting In Neovim And Replace null-ls](https://www.josean.com/posts/neovim-linting-and-formatting)
    [Neovim Plugins and Configuration Recipes | 3](https://alpha2phi.medium.com/neovim-plugins-and-configuration-recipes-3-c597be9d46ac)
    [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
    [How to disable autoformating on save on LazyVim?](https://vi.stackexchange.com/questions/42597/how-to-disable-autoformating-on-save-on-lazyvim)
]]

-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    options                                                                     -- aka {opts}, keymap options
  )
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    enabled = true,
    lazy = false,
    event = 'BufReadPre',
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }                      -- filetypes you wish to not autoformat
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then     -- disable formatting with a global or buffer-local variable
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = { -- listing of filetypes and ther formatters
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },

    -- disable auto formatting on save, see [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
    vim.api.nvim_create_user_command('ToggleFormatting', function(args)
      if args.bang then                                                         -- ToggleFormatting! will toggle formatting just for this buffer
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false                                      -- enable formatting for just this buffer
        else
          vim.b.disable_autoformat = true                                       -- disable formatting for just this buffer
        end
      else
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false                                      -- enable formatting for all buffer
        else
          vim.g.disable_autoformat = true                                       -- disable formatting for all buffer
        end
      end
    end, {
      desc = 'Toggle Autoformatting on Save (aka ToggleFormatting)',
      bang = true,
    }),

    -- toggle on/off auto formatting on save, default is 'no formatting'
    keymap('n', '<leader>tfa', '<cmd>ToggleFormatting<cr>', { desc = '[T]oggle [F]Formatting on [A]ll Buffers' }),    -- toggle code formatting for all languages & buffers
    keymap('n', '<leader>tfb', '<cmd>ToggleFormatting!<cr>', { desc = '[T]oggle [F]Formatting Only This [B]uffer' }), -- toggle code formatting for only this buffer
  },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
