
--------------------------------------------------------------------------------
-- ide-enhanced/configs/lsp/lsp-config.lua

-- Mason allows you to easily manage external editor tooling such as LSP servers,
-- DAP servers, linters, and formatters through a single interface.

-- NOTE: nvim-lsp-installer is no longer maintained. `mason.nvim` is the next
-- generation version of nvim-lsp-installer.

--    :help bufferline-configuration   - see all configuration options

--    :Mason                             - opens a graphical status window
--    :MasonUpdate                       - updates all managed registries
--    :MasonInstall <package> ...        - installs/re-installs the provided packages
--    :MasonUninstall <package> ...      - uninstalls the provided packages
--    :MasonUninstallAll                 - uninstalls all packages
--    :MasonLog                          - opens the mason.nvim log file in a new tab window

-- Sources:
--    [GitHub: williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
--    [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE)
--    [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
--    [Modern Neovim for the faint of heart](https://rdrn.me/neovim/)
--    [Neovim configuration from scratch to LSP](https://blog.pulkitgangwar.com/neovim-configuration-from-scratch-to-lsp)
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- ide-enhanced/configs/lsp/lsp-config.lua

-- mason-lspconfig.nvim bridges mason.nvim with the nvim-lspconfig plugin,
-- making it easier to use both plugins together.
-- Its main responsibilities are to:

--    1. translate between nvim-lspconfig server names and mason.nvim package names
--    2. automatically install, and automatically set up a predefined list of servers
--    3. provide extra convenience APIs such as the :LspInstall command
--    4. available LSP servers - https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

--    :help mason-lspconfig-commands     - see all the configuration options
--    :help mason-lspconfig-settings     - see all the setup() options

--    :LspInfo
--    :LspLog
--    :LspRestart
--    :LspInstall [<server>...]          - installs the provided servers
--    :LspUninstall <server> ...         - uninstalls the provided servers

-- Sources:
--    [GitHub: williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
--    [GitHub: williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
--    [Neovim - LSP Setup Tutorial (Built in LSP 100% Lua)](https://www.youtube.com/watch?v=6F3ONwrCxMg)
--    [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
--    [Modern Neovim for the faint of heart](https://rdrn.me/neovim/)
--    [Neovim configuration from scratch to LSP](https://blog.pulkitgangwar.com/neovim-configuration-from-scratch-to-lsp)
--    [Make lsp-zero.nvim coexists with other plugins instead of controlling them](https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80)
--------------------------------------------------------------------------------


-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/mason.lua


-- if you haven't loaded these plugins, do no operation and return
--local status_ok_1, mason = pcall(require, 'mason')
local status_ok_1, _ = pcall(require, 'mason')
if not status_ok_1 then
  print("'configs/lua/mason.lua' not installed, taking no action")
  return
end

--local status_ok_2, mason-lspconfig = pcall(require, 'mason-lspconfig')
--if not status_ok_2 then
  --print("'configs/lua/mason-lspconfig.lua' not installed, taking no action")
  --return
--end

local status_ok_3, lspconfig = pcall(require, 'lspconfig')    -- we'll need to call lspconfig to pass our server to the native neovim lspconfig
if not status_ok_3 then
  print("'configs/lua/nvim-lspconfig.lua' not installed, taking no action")
  return
end


-- initialize mason -----------------------------------------------------------
require('mason').setup {
  ui = {
    border = 'rounded',
    icons = {                            -- icons used to show lsp server installtion status
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}


-- initialize LSP --------------------------------------------------------------
--local lsp = require('lsp-zero').preset({
  --name = 'minimal',
  --set_lsp_keymaps = true,
  --manage_nvim_cmp = true,
  --suggest_lsp_servers = false,
--})
--
--lsp.nvim_workspace()
--lsp.setup()

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/tutorial.md#complete-example
local lsp = require('lsp-zero').preset({})

--lsp.on_attach(function(client, bufnr)
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


-- lsp servers to be auto-installed - source is
local servers = {
  --'tsserver',                            -- TypeScript language server, https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver)
  --'sumneko_lua',                         -- Lua language server, this has been deprecated and replaced by lua_ls
  'lua_ls',                              -- Lua language server
  'pyright',                             -- Python language server - static type checker for python, https://github.com/microsoft/pyright
  'clangd',                              -- C++ language server
  'ansiblels',                           -- Ansible language server
  'arduino_language_server',             -- Arduino language server
  'marksman',                            -- Markdown language server
  --'bashls',                            -- Bash language server, https://github.com/bash-lsp/bash-language-server
  --'html',
  --'vimls',
  --'emmet_ls',
}

-- initialize mason-lspconfig
require('mason-lspconfig').setup {
  ensure_installed = servers,            -- auto-install LSP servers
  automatic_installation = true,
}

-- loop through all the lsp servers and attach to them
local opts = {}
for _, server in pairs(servers) do
    opts = { -- getting 'on_attach' and 'capabilities' from handlers.lua file
        on_attach = require('ide-enhanced.configs.lsp.handlers').on_attach,
        capabilities = require('ide-enhanced.configs.lsp.handlers').capabilities,
    }
    server = vim.split(server, '@')[1]     -- get the server name
    local require_ok, conf_opts = pcall(require, 'ide-enhanced.configs.lsp.settings.' .. server)
	  if require_ok then
		  opts = vim.tbl_deep_extend('force', conf_opts, opts)
	  end
    lspconfig[server].setup(opts)         -- pass them to lspconfig
end

