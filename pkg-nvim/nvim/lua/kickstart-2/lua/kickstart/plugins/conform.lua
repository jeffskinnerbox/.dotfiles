-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ Lightweight yet powerful formatter plugin for Neovim
kickstart2/lua/kickstart/plugins/conform.lua

  Description:
    This is is a lightweight, yet powerful, formatter plugin for Neovim.
    It is a good alternative to null-ls.nvim in terms of formatting.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
    [How To Setup Linting & Formatting In Neovim And Replace null-ls](https://www.josean.com/posts/neovim-linting-and-formatting)
    [Configure Linting, Formatting, and Autocompletion in Neovim](https://levelup.gitconnected.com/configure-linting-formatting-and-autocompletion-in-neovim-a2cf15e2e04d)
    [Neovim Plugins and Configuration Recipes | 3](https://alpha2phi.medium.com/neovim-plugins-and-configuration-recipes-3-c597be9d46ac)
    [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
    [How to disable autoformating on save on LazyVim?](https://vi.stackexchange.com/questions/42597/how-to-disable-autoformating-on-save-on-lazyvim)
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
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {                                                      -- listing of filetypes and there formatters
        --lua = { 'stylua' },
        cpp = { 'clang-format' },                                               -- formatter for the c++ language
        python = { 'isort', 'black' },                                          -- conform can also run multiple formatters sequentially, order is important
        javascript = { 'prettier' },                                            -- you can use a sub-list to tell conform to run *until* a formatter is found, e.g. javascript = { { "prettierd", "prettier" } },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        --markdown = { "markdownlint" },                                        -- linter and formatter for markdown language
      },
      format_on_save = {                                                        -- should you format when you save the file
        lsp_fallback = vim.g.auto_format_on_save,                               -- 'false' means do not format on save, you must request via keymap below
        async = false,
        timeout_ms = 1000,
      },
    })

    -- request formatting via keymap in normal and visual modes
    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = '[C]ode [F]ormating for Whole File or Range (in Visual Mode)' })
  end,
}

--[[
return {
  { -- Autoformat
    'stevearc/conform.nvim',
    enabled = true,
    lazy = false,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = ''
        desc = '[F]ormat Buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true } -- filetypes you wish to not autoformat
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then -- disable formatting with a global or buffer-local variable
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
      if args.bang then -- ToggleFormatting! will toggle formatting just for this buffer
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false -- enable formatting for just this buffer
        else
          vim.b.disable_autoformat = true -- disable formatting for just this buffer
        end
      else
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false -- enable formatting for all buffer
        else
          vim.g.disable_autoformat = true -- disable formatting for all buffer
        end
      end
    end, {
      desc = 'Toggle Autoformatting on Save (aka ToggleFormatting)',
      bang = true,
    }),

    -- toggle on/off auto formatting on save, default is 'no formatting'
    keymap('n', '<leader>Tfa', '<cmd>ToggleFormatting<cr>', { desc = '[T]oggle [F]Formatting on [A]ll Buffers' }), -- toggle code formatting for all languages & buffers
    keymap('n', '<leader>Tfb', '<cmd>ToggleFormatting!<cr>', { desc = '[T]oggle [F]Formatting Only This [B]uffer' }), -- toggle code formatting for only this buffer

  },
}
--]]
