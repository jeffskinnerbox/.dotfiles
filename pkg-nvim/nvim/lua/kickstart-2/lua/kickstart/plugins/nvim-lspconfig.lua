-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

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
      <leader>sp               - toggle spell checking

  Sources:
    [GitHub: neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
    [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
    [Neovim LSP Basics](https://levelup.gitconnected.com/neovim-lsp-basics-b0ade96fe96d)
]]

-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                        -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                         -- aka {lhs}, key sequence to trigger result
    result,                                                                      -- aka {rhs}, command or key subsituation to be made
    options                                                                      -- aka {opts}, keymap options
  )
end

return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {                                                            -- automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },                             -- easily install and manage LSP servers, DAP servers, linters, and formatters, must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',                                      -- extension of mason.nvim that bridges mason.nvim with the nvim-lspconfig plugin, making it easier to use both plugins together
      'WhoIsSethDaniel/mason-tool-installer.nvim',                              -- install and upgrade third party tools (e.g. formatters, linters) automatically
      'hrsh7th/cmp-nvim-lsp',
      { 'antosha417/nvim-lsp-file-operations', config = true },
      { 'j-hui/fidget.nvim', opts = {} },                                       -- provides useful status updates for LSP, `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'folke/neodev.nvim', opts = {} },                                       -- `neodev` configures Lua LSP to support vim commands, runtime and plugins used for completion, annotations and signatures of Neovim apis
    },
    -- This function gets run when an LSP attaches to a particular buffer.
    -- That is to say, every time a new file is opened that is associated with
    -- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    -- function will be executed to configure the current buffer
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require('telescope.builtin')
          map('jd', builtin.lsp_definitions, '[J]ump to [D]efinition')                         -- jump to the definition of the word under your cursor, This is where a variable was first declared, or where a function is defined, etc, to jump back, press <C-t>.
          map('<leader>jh', vim.lsp.buf.declaration, '[J]ump to Declaration (aka [Header])')                        -- this is not Goto Definition, this is Goto Declaration, for example, in C this would take you to the header
          map('<leader>jr', builtin.lsp_references, '[J]ump to [R]eferences')                  -- find references for the word under your cursor
          map('<leader>jI', builtin.lsp_implementations, '[J]ump to [I]mplementation')         -- jump to the implementation of the word under your cursor, useful when your language has ways of declaring types without an actual implementation
          map('<leader>jD', builtin.lsp_type_definitions, '[J]ump to Type [D]efinition')       -- jump to the type of the word under your cursor, useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
          map('<leader>js', builtin.lsp_document_symbols, '[J]ump to [S]ymbol')                -- fuzzy find all the symbols in your current document, symbols are things like variables, functions, types, etc.
          map('<leader>jb', builtin.buffers, '[J]ump to [B]uffers')
          --map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')  -- fuzzy find all the symbols in your current workspace, similar to document symbols, except searches over your entire project
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[N]ame Varable Under Cursor')                                  -- rename the variable under your cursor, most language servers support renaming across files, etc.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')                                             -- execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')                                                        -- opens a popup that displays documentation about the word under your cursor, see `:help K` for why this keymap

          -- The following autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          -- See `:help CursorHold` for information about when this is executed

          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them

          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>Th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '✓',                                            -- the list icon to use for installed packages
            package_pending = '➜',                                              -- the list icon to use for packages that are installing, or queued for installation
            package_uninstalled = '✗',                                          -- the list icon to use for  that are not installed
          },
        },
      })

      -- You can add other tools here that you want Mason to install for you,
      -- so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'luacheck',                                                             -- lua linter
        'isort',                                                                -- python formatter
        'black',                                                                -- python formatter
        'markdownlint',                                                         -- markdown linter & formatter
        'pylint',                                                               -- python linter
      })

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
