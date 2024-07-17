-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

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

return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    enabled = true,
    event = 'InsertEnter',                                                      -- load this plugin when nvim enters insert mode
    dependencies = {                                                            -- adds other completion capabilities required by 'nvim-cmp', nvim-cmp does not ship with all sources by default, they are split into multiple repos for maintenance purposes.
      'hrsh7th/cmp-buffer',                                                     -- nvim-cmp source for text in buffer
      'hrsh7th/cmp-path',                                                       -- nvim-cmp source for filesystem paths
      'hrsh7th/cmp-nvim-lsp',                                                   -- nvim-cmp source for neovim's built-in language server client
      'neovim/nvim-lspconfig',                                                  -- configuration plugin for the nvim lsp
      'onsails/lspkind-nvim',                                                   -- small plugin adds vscode-like pictograms to neovim built-in lsp
      'saadparwaiz1/cmp_luasnip',                                               -- 'LuaSnip' completion source for 'nvim-cmp'
      { 'L3MON4D3/LuaSnip',                                                     -- plugin L3MON4D3/LuaSnip, which, together with rafamadriz/friendly-snippets, lets you create shortcuts for snippets, it supports many languages and is often updated, please review the friendly-snippets repository to learn what snippets apply to your file types, see the README about individual language/framework/plugin snippets: https://github.com/rafamadriz/friendly-snippets
        version = 'v2.*',
        build = (
          function() -- build step is needed for regex support in snippets, this step is not supported in many windows environments, remove the below condition to re-enable on windows
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end
        )(),
        dependencies = {
          { 'rafamadriz/friendly-snippets',                                  -- plugin L3MON4D3/LuaSnip, which, together with rafamadriz/friendly-snippets, lets you create shortcuts for snippets, it supports many languages and is often updated, please review the friendly-snippets repository to learn what snippets apply to your file types, see the README about individual language/framework/plugin snippets: https://github.com/rafamadriz/friendly-snippets
             config = function()
               require('luasnip.loaders.from_vscode').lazy_load()
             end,
          },
        },
      },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      require("luasnip.loaders.from_vscode").lazy_load()                        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)

      luasnip.config.setup {}

      cmp.setup({
        completion = { completeopt = 'menu,menuone,preview,noinsert' },
        snippet = {                                                             -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),                           -- select the [n]ext item
          ['<C-p>'] = cmp.mapping.select_prev_item(),                           -- select the [p]revious item
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),                              -- scroll the documentation window back
          ['<C-f>'] = cmp.mapping.scroll_docs(4),                               -- scroll the documentation window forward
          ["<C-Space>"] = cmp.mapping.complete(),                               -- manually trigger a completion suggestions, generally you don't need this, because nvim-cmp will display, completions whenever it has completion options available
          ["<C-e>"] = cmp.mapping.abort(),                                      -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          --['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
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

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = "nvim_lsp"},
          { name = "luasnip" },                                                 -- snippets
          { name = "buffer" },                                                  -- text within current buffer
          { name = "path" },                                                    -- file system paths
        },
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
}

