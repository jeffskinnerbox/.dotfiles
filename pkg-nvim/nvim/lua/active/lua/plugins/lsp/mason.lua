-- luacheck: globals vim
-- luacheck: max line length 300

--[[ nvim-lspconfig is a collection of configurations for various language servers
kickstart2/lua/kickstart/plugins/nvim-lspconfig.lua

  Description:
    This plugin sets the configuration needed for interacting with LSP servers
    and configuration for the Neovim LSP client.

    LSP stands for Language Server Protocol, which is meant to standardize the
    format or protocol for how language servers and clients communicate.
    A LSP enables code analysis, autocomplete, linting, and other features
    through language-specific servers.

    It communicates with all the LSP servers to get all the modern
    IDE features like code completion, error & warning markings, highlighting,
    and auto refactoring & formatting. It is also ere where different
    programming languages are turned on/off.

    1. Sensible defaults for various LSP
    2. Launch LSP automatically for corresponding filetypes
    If you only use a few language servers and have enough free time you can do the above by yourself.

  Definitions:
    What is LSP? LSP stands for Language Server Protocol (LSP). It's a protocol that
    helps editors and language tooling communicate in a standardized fashion.
    In general, you have a "server" which is some tool built to understand a particular
    language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    processes that communicate with some "client" - in this case, Neovim!

    LSP provides Neovim with features like: Go to definition Find references,
    Autocompletion, Symbol Search, and more! Thus, Language Servers are
    external tools that must be installed separately from Neovim. This is where
    `mason` and related plugins come into play.

    If you're wondering about LSP vs Treesitter, you can check out the wonderfully
    and elegantly composed help section, `:help lsp-vs-treesitter`

  Usage:
    list of the most significant commandline and keymap operations

    Commandline
      :help lspconfig-all                 - LSP configs provided by nvim-lspconfig are listed
      :LspInfo                            - status information about your LSP setup
      :Mason                              - List what LSP servers, DAP, Linter, Formatter servers are install and available, search for what you need and press the 'i' key to install the server, if you no longer need a server use the 'X' key
      :MasonInstall <lsp-server>          - install server for specific language, in this case the Lua language
      :MasonToolInstall <tool>

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
    [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
    [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
    [Neovim LSP Basics](https://levelup.gitconnected.com/neovim-lsp-basics-b0ade96fe96d)

  NOTE: Make sure that nvim-lspconfig.lua, mason.lua, conform.lua, and nvim-lint.lua all agree on what linter & formatter will be used for each filetype
]]


 -- Mason easily install and manage LSP servers, DAP servers, linters, and formatters
return {
  "williamboman/mason.nvim",
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  dependencies = {
    { 'williamboman/mason-lspconfig.nvim' },                                    -- extension of mason.nvim that bridges mason.nvim with the nvim-lspconfig plugin, making it easier to use both plugins together
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },                            -- install and upgrade third party tools (e.g. formatters, linters) automatically
  },
  config = function()
    local mason = require("mason")                                              -- import mason
    local mason_lspconfig = require("mason-lspconfig")                          -- import mason-lspconfig
    local mason_tool_installer = require("mason-tool-installer")                -- import mason-tool-installer

    -- enable mason and set configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- list of language servers you want Mason to install at startup (NOTE: currently supporting only lua, python, sh, markdown, yaml, json)
    mason_lspconfig.setup({
      ensure_installed = {                                                      -- list of servers for mason to install
        'lua_ls',                                                               -- language server for lua language
        "pyright",                                                              -- language server for python language
        'bashls',                                                               -- language server for bash shell language, requires npm to be installed
        --'ast-grep',                                                             -- language server for cpp language
        --'clangd',                                                               -- language server for cpp language
        'marksman',                                                             -- language server for markdown language
        'yamlls',                                                               -- language server for yaml language, requires npm to be installed
        --'cssls',                                                                -- language server for css language, requires npm to be installed
        --'html',                                                                 -- language server for html language, requires npm to be installed
        'jsonls',                                                               -- language server for json language, requires npm to be installed
      },
    })

    -- linters, formatters, debuggers, other tools that you want Mason to install at startup (NOTE: currently supporting only lua, python, sh, markdown, yaml, json)
    mason_tool_installer.setup({
      ensure_installed = {
        'luacheck',                                                             -- lua linter
        --"stylua",                                                               -- lua formatter
        'pylint',                                                               -- python linter
        --'flake8',                                                               -- python linter
        --'mypy',                                                                 -- python linter
        'isort',                                                                -- python formatter
        'black',                                                                -- python formatter
        --'debugpy',                                                              -- python debugger
        'shellcheck',                                                           -- shell linter
        'beautysh',                                                             -- shell formatter
        --'ast-grep',                                                             -- cpp linter
        --'ast-grep',                                                             -- cpp formatter
        'markdownlint',                                                         -- markdown linter & formatter
        'yamllint',                                                             -- yaml linter
        'prettier',                                                             -- yaml formater
        --'ast-grep',                                                             -- css linter
        --'prettier',                                                             -- css formatter
        --'ast-grep',                                                             -- html linter
        --'prettier',                                                             -- html formatter
        'jsonlint',                                                             -- json linter
        'prettier',                                                             -- json formatter
      },
    })
  end,
}

