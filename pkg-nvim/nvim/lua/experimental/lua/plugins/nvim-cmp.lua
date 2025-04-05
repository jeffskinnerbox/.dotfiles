-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin that does autocompletion while you type coding lanugage
kickstart2/lua/kickstart/plugins/nvim-tneoree.lua

  Description:
    This is a completion engine plugin for neovim written in Lua. iompletion sources
    are installed from external repositories and are "sourced" within the configuration below.

    The 'nvim-cmp' plugin does not ship with all its sources by default. These include
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', and 'neovim/nvim-lspconfig'.
    They are split into multiple GitHub repositories for maintenance purposes.

  Usage:
    Commandline
      Known that I use or aware of.

    Mapped Key Commands
      Known that I use or aware of.

  Sources:
    [GitHub: hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    [nvim-cmp - Weekly Neovim Plugin](https://www.youtube.com/watch?v=Vgb_UERSKPA)
    [How to Install and Use nvim cmp Autocompletion](https://linovox.com/install-and-use-nvim-cmp/)
    [Code Completion for Neovim using Lazy](https://medium.com/@shaikzahid0713/code-completion-for-neovim-6127401ebec2)
]]


-- Autocompletion -taken from https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-cmp.lua & https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-cmp.lua
return {
  'hrsh7th/nvim-cmp',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = 'InsertEnter',                                                        -- load this plugin when nvim enters insert mode
  dependencies = {                                                              -- adds other completion capabilities required by 'nvim-cmp', nvim-cmp does not ship with all sources by default, they are split into multiple repos for maintenance purposes.
    'hrsh7th/cmp-buffer',                                                       -- nvim-cmp source for text in buffer
    'hrsh7th/cmp-path',                                                         -- nvim-cmp source for filesystem paths
    'hrsh7th/cmp-cmdline',                                                      -- nvim-cmp source for filesystem comandline
    'hrsh7th/cmp-nvim-lsp',                                                     -- nvim-cmp source for neovim's built-in language server client
    'neovim/nvim-lspconfig',                                                    -- configuration plugin for the nvim lsp
    'onsails/lspkind-nvim',                                                     -- small plugin adds vscode-like pictograms to neovim built-in lsp
    'saadparwaiz1/cmp_luasnip',                                                 -- 'LuaSnip' completion source for 'nvim-cmp'
    { 'L3MON4D3/LuaSnip',                                                       -- plugin L3MON4D3/LuaSnip, which, together with rafamadriz/friendly-snippets, lets you create shortcuts for snippets, it supports many languages and is often updated, please review the friendly-snippets repository to learn what snippets apply to your file types, see the README about individual language/framework/plugin snippets: https://github.com/rafamadriz/friendly-snippets
      version = 'v2.*',
      build = (
        function()                                                              -- build step is needed for regex support in snippets, this step is not supported in many windows environments, remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end
      )(),
      dependencies = {
        { 'rafamadriz/friendly-snippets',                                       -- plugin L3MON4D3/LuaSnip, which, together with rafamadriz/friendly-snippets, lets you create shortcuts for snippets, it supports many languages and is often updated, please review the friendly-snippets repository to learn what snippets apply to your file types, see the README about individual language/framework/plugin snippets: https://github.com/rafamadriz/friendly-snippets
           config = function()
             require('luasnip.loaders.from_vscode').lazy_load()
           end,
        },
      },
    },
  },

  config = function()
    local cmp = require('cmp')                                                  -- load nvim-cmp
    local luasnip = require('luasnip')                                          -- load cmp_luasnip
    local lspkind = require('lspkind')                                          -- load lspkind-nvim
    require("luasnip.loaders.from_vscode").lazy_load()                          -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    luasnip.config.setup({})

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {                                                               -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- for an understanding of why these mappings were chosen, you will need to read `:help ins-completion`
      -- for more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),                             -- select the [n]ext item
        ['<C-p>'] = cmp.mapping.select_prev_item(),                             -- select the [p]revious item
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),                                -- scroll the documentation window back
        ['<C-f>'] = cmp.mapping.scroll_docs(4),                                 -- scroll the documentation window forward
        ["<C-Space>"] = cmp.mapping.complete(),                                 -- manually trigger a completion suggestions, generally you don't need this, because nvim-cmp will display, completions whenever it has completion options available
        ["<C-e>"] = cmp.mapping.abort(),                                        -- close completion window
        ['<C-y>'] = cmp.mapping.confirm { select = true },                      -- accept ([y]es) the completion, this will auto-import if your LSP supports it, this will expand snippets if the LSP sent a snippet
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm {                                        -- confirm the selection
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)                              -- tab through suggestions or when a snippet is active, tab to the next argument
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)                            -- tab backwards through suggestions or when a snippet is active, tab to the next argument
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp"},                                                   -- lsp
        { name = "luasnip" },                                                   -- snippets
        { name = "buffer" },                                                    -- text within current buffer
        { name = "path" },                                                      -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

        -- add borders to completions & documentation popups
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

    })

  end,
}

