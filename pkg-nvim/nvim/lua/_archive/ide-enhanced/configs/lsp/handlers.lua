-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/handlers.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls


local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' }, -- colored red
    { name = 'DiagnosticSignWarn',  text = '' }, -- colored orange
    { name = 'DiagnosticSignHint',  text = '' }, -- colored purple
    { name = 'DiagnosticSignInfo',  text = '' }, -- colored lightblue
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs,     -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

-- when a language server gets attached to a buffer, you gain access to some keybindings and commands.
-- all of these are bound to built-in functions, so you can get more details using the ':help <command>'.
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#default-keybindings
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)                            -- display hover information about the symbol under the cursor in a floating window
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)                      -- jump to the definition of the symbol under the cursor
  keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)                     -- jump to the declaration of the symbol under the cursor - NOTE: Some servers don't implement this feature
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)                  -- list all the implementations for the symbol under the cursor in the quickfix window
  --keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)                  -- list all the implementations for the symbol under the cursor in the quickfix window
  keymap(bufnr, 'n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)                 -- jump to the definition of the type of the symbol under the cursor
  keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)                      -- list all the references to the symbol under the cursor in the quickfix window
  keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)                   -- show diagnostics in a floating window
  keymap(bufnr, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', opts)
  keymap(bufnr, 'n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  --keymap(bufnr, 'n', '<leader>lI', '<cmd>LspInstallInfo<cr>', opts)
  keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  keymap(bufnr, 'n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>', opts)
  keymap(bufnr, 'n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>', opts)
  keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

M.on_attach = function(client, bufnr)
  -- Python language server (static type checker for python) - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
  if client.name == 'pyright' then
    client.server_capabilities.documentFormattingProvider = false
    require 'lspconfig'.pyright.setup {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'workspace',
            useLibraryCodeForTypes = true,
          },
        },
      },
    }
  end

  -- Markdown language server - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
  if client.name == 'marksman' then
    client.server_capabilities.documentFormattingProvider = false
    require'lspconfig'.marksman.setup {
      --filetypes = { 'markdown', 'md' },
      settings = {
        filetypes = { 'markdown', 'md' },
      }
    }
  end

  -- Lua language server - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
  if client.name == 'lua_ls' then
    client.server_capabilities.documentFormattingProvider = false
    require 'lspconfig'.lua_ls.setup {                              -- taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',                                     -- tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          },
          diagnostics = {
            globals = { 'vim' },                                    -- this removes "Lua Diagnostics.: Undefined global vim", - get the language server to recognize the `vim` as a global
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),      -- make the server aware of Neovim runtime files
            checkThirdParty = false,                                -- this removes the prompt "Do you need to configure your work environment to 'luasert'?" - https://github.com/neovim/nvim-lspconfig/issues/1700
          },
          telemetry = {
            enable = false,                                         -- do not send telemetry data containing a randomized but unique identifier
          },
        },
      },
    }
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, 'illuminate')
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M

