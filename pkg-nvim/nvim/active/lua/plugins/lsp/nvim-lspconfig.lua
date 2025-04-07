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
      :MasonInstall lua-language-server   - install server for specific language, in this case the Lua language

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp                          - toggle spell checking

  Sources:
    [GitHub: neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
    [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
    [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
    [Neovim LSP Basics](https://levelup.gitconnected.com/neovim-lsp-basics-b0ade96fe96d)

  NOTE: Make sure that nvim-lspconfig.lua, mason.lua, conform.lua, and nvim-lint.lua all agree on what linter & formatter will be used for each filetype
]]


-- configure all the LSP servers
return {
  "neovim/nvim-lspconfig",
  enabled = true,                                                               -- load th plugin if 'true' but skip completely if 'false'
  event = { "BufReadPre", "BufNewFile" },                                       -- load the plugin when you read an existing file or new buffer is created
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",                                                     -- support for lsp assisted autocompletions
    { "antosha417/nvim-lsp-file-operations", config = true },                   -- allow you rename files through nvim-tree and auto-updates effected code
    { 'folke/neodev.nvim', opts = {} },                                         -- `neodev` configures Lua LSP to support vim commands, runtime and plugins used for completion, annotations and signatures of Neovim apis
    { 'j-hui/fidget.nvim', opts = {} },                                         -- provides useful status updates for LSP, `opts = {}` is the same as calling `require('fidget').setup({})`
  },

  config = function()
    local lspconfig = require("lspconfig")                                      -- import lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")                          -- import mason-lspconfig plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")                                -- import cmp-nvim-lsp plugin     BUG: remove this? - non-sense I think

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
        -- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
        local keymap = function(mode, key, result, options)
        vim.keymap.set(
          mode,                                                               -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
          key,                                                                -- aka {lhs}, key sequence to trigger result
          result,                                                             -- aka {rhs}, command or key subsituation to be made
          { desc = 'LSP: ' .. options, buffer = ev.buf, silent = true }       -- aka {opts}, keymap discription, 'TS:' means this is a telescope function
        )
        end

        -- set keymappings relivent to LSP
        keymap('n', 'gR', "<cmd>Telescope lsp_references<CR>", "Show LSP references" )                     -- show definition, references
        keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")                                    -- go to declaration
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")                    -- show lsp definitions
        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")            -- show lsp implementations
        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")          -- show lsp type definitions
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")          -- see available code actions, in visual mode will apply to selection
        keymap("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")                                      -- smart rename
        keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")      -- show  diagnostics for file
        keymap("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")                       -- show diagnostics for line
        keymap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")                           -- jump to previous diagnostic in buffer
        keymap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")                               -- jump to next diagnostic in buffer
        keymap("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")                 -- show documentation for what is under cursor
        keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")                                    -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- change the diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"                                    -- set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end

    mason_lspconfig.setup_handlers({
      function(server_name)                                                     -- default handler for all installed servers below
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- configure lua server (with special settings)
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },                                            -- make the language server recognize "vim" global
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,

      -- configure python language server and map to filetypes
      ["pyright"] = function()
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          filetypes = { "py", },
        })
      end,

      -- configure bash language server and map to filetypes
      ["bashls"] = function()
        lspconfig["bashls"].setup({
          capabilities = capabilities,
          filetypes = { "sh", },
        })
      end,

      -- configure markdown language server and map to filetypes
      ["marksman"] = function()
        lspconfig["marksman"].setup({
          capabilities = capabilities,
          filetypes = { "markdown", "mdown", "mkdn", "mkd", "mdwn", "md", },
        })
      end,

      -- configure yaml language server and map to filetypes
      ["yamlls"] = function()
        lspconfig["yamlls"].setup({
          capabilities = capabilities,
          filetypes = { "ymal", "yml", },
        })
      end,

--[[
      -- configure svelte server
      ["svelte"] = function()
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,

      -- configure graphql language server
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,

      -- configure emmet language server
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
]]--
    })
  end,
}

