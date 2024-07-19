-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support
kickstart2/lua/kickstart/plugins/nvim-lint.lua

  Description:
    describe what this plugin does

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
    [How To Setup Linting & Formatting In Neovim And Replace null-ls](https://www.josean.com/posts/neovim-linting-and-formatting)
    [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)
    [LuaCheck Documentation: Inline Options](https://luacheck.readthedocs.io/en/stable/inline.html)
    [MarkdownLint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html)
]]

-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode, -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key, -- aka {lhs}, key sequence to trigger result
    result, -- aka {rhs}, command or key subsituation to be made
    options -- aka {opts}, keymap options
  )
end

return {
  'mfussenegger/nvim-lint',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = { -- set which linters you plan to use per filetype
      -- Linters
      cpp = { 'cpplint' },                                                      -- linter for c++ language
      lua = { 'luacheck' },                                                     -- linter for lua language
      python = { 'pylint' },                                                    -- linter for python language
      makefile = { 'checkmake' },                                               -- linter for makefile language
      markdown = { 'markdownlint' },                                            -- linter and formatter for markdown language
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },

      -- Formatters
      --lua = { "stylua" },                                                       -- formatter for the Lua language
      --cpp = { "clang-format" },                                                 -- formatter for the c++ language
      --python = { "black" },                                                     -- formatter for the python language
      --markdown = { "markdownlint" },                                            -- linter and formatter for markdown language
      --makefile = { },

      -- LSP Language Servers
      --lua = { 'lua-language-server' },                                          -- language server for the lua language
      --cpp = { 'clangd' },                                                       -- language server for the c++ language
      --python = { "python-lsp-server" },                                         -- language server for the python language
      --markdown = { "grammarly-languageserver" },                                -- language server for the markdown language
      --makefile = { },
    }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- create autocommand which carries out the actual linting on the specified events
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {            -- trigger linting on these events
      group = lint_augroup,
      callback = function()
        lint.try_lint()                                                                      -- do the linting
      end,
    })

    -- setup a keymap so user can trigger linting manually
    keymap('n', '<leader>cl', 'function() lint.try_lint() end', { desc = 'Lint: Trigger [C]ode [L]inter for Current Buffer' })
  end,
}
