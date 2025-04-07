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
    nvim-lint
      [GitHub: mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
      [How To Setup Linting & Formatting In Neovim And Replace null-ls](https://www.josean.com/posts/neovim-linting-and-formatting)
      [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)
    Lua Linter
      [LuaCheck Documentation: Inline Options](https://luacheck.readthedocs.io/en/stable/inline.html)
    Markdown Linter
      [MarkdownLint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html)
      [markdownlint: A Node.js style checker and lint tool for Markdown/CommonMark files](https://www.npmjs.com/package/markdownlint)
      [markdownlint-cli: Command Line Interface for MarkdownLint](https://www.npmjs.com/package/markdownlint-cli)
      [Notes on Markdown linting - part 1](https://qmacro.org/blog/posts/2021/05/13/notes-on-markdown-linting-part-1/)
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
  'mfussenegger/nvim-lint',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = { -- for each file type, set which linters you plan to use
      -- Linters
      --bash = { "shellharden" },                                                 -- linter and formatter for bash shell language
      bash = { "shellcheck" },                                                  -- linter for bash shell language
      lua = { 'luacheck' },                                                     -- linter for lua language
      cpp = { 'cpplint' },                                                      -- linter for c++ language
      python = { 'pylint' },                                                    -- linter for python language
      markdown = { 'markdownlint' },                                            -- linter and formatter for markdown language
      javascript = { 'ast-grep' },                                              -- linter and formatter for javascript, you can use a sub-list to tell conform to run *until* a formatter is found, e.g. javascript = { { "prettierd", "prettier" } },
      css = { 'ast-grep' },                                                     -- linter and formatter for css
      html = { 'ast-grep' },                                                    -- linter and formatter for html
      json = { 'ast-grep' },                                                    -- linter and formatter for json
      yaml = { 'prettier' },                                                    -- linter and formatter for yaml
      cmake = { "cmakelang" },                                                  -- linter and formatter for the cmake language
      makefile = { 'checkmake' },                                               -- linter for makefile language
      ansible = { 'ansible-lint' },                                             -- linter for ansible language
      docker = { 'hadolint' },                                                  -- linter for docker language

      -- Formatters
      --bash = { },                                                               -- for formating of bash shell, must use 'shellharden'
      --bash = { "shellharden" },                                                 -- linter and formattet for bash shell language
      --lua = { "stylua" },                                                       -- formatter for the Lua language
      --cpp = { "clang-format" },                                                 -- formatter for the c++ language
      --python = { "isort", "black" },                                            -- formatter for the python language, conform can also run multiple formatters sequentially, order is important
      --markdown = { "markdownlint" },                                            -- linter and formatter for markdown language
      --javascript = { 'ast-grep' },                                              -- linter and formatter for javascript, you can use a sub-list to tell conform to run *until* a formatter is found, e.g. javascript = { { "prettierd", "prettier" } },
      --css = { 'ast-grep' },                                                     -- linter and formatter for css
      --html = { 'ast-grep' },                                                    -- linter and formatter for html
      --json = { 'ast-grep' },                                                    -- linter and formatter for json
      --yaml = { 'prettier' },                                                    -- linter and formatter for yaml
      --cmake = { "cmakelang" },                                                  -- linter and formatter for the cmake language
      --makefile = { },                                                           -- formatter doesn't exist for makefile
      --ansible = { },                                                            -- formatter doesn't exist for ansible
      --docker = { },                                                             -- formatter doesn't exist for docker

      -- LSP Language Servers
      --bash = { "bash-language-server" },                                        -- language server for bash shell language
      --lua = { 'lua-language-server' },                                          -- language server for the lua language
      --cpp = { 'clangd' },                                                       -- language server for the c++ language
      --python = { "python-lsp-server" },                                         -- language server for the python language
      --markdown = { "grammarly-languageserver" },                                -- language server for the markdown language
      --javascript = { "lwc-language-server" },                                   -- language server for the html & javascript languages
      --css = { "cssmodules-language-server" },                                   -- language server for the css languages
      --html = { "lwc-language-server" },                                         -- language server for the html & javascript languages
      --json = { "json-lsp" },                                                    -- language server for the json languages
      --yaml = { "yaml-language-server" },                                        -- language server for the yaml languages
      --makefile = { },                                                           -- language server for makefile does not exist
      --cmake = { "cmake-language-server" },                                      -- language server for cmake language
      --ansible = { 'ansible-language-server' },                                  -- language server for the ansible language
      --docker = { 'dockerfile-language-server', 'docker-compose-language-server' },  -- language server for the dockerfile & docker-compose language
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
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {  -- trigger linting on these events
      group = lint_augroup,
      callback = function()
        lint.try_lint()                                                           -- do the linting
      end,
    })

    -- setup a keymap so user can trigger linting manually
    keymap('n', '<leader>cl', 'function() lint.try_lint() end', { desc = 'Lint: Trigger [C]ode [L]inter for Current Buffer' })
  end,
}
