
--------------------------------------------------------------------------------
-- active/cmp.lua

--

-- Sources:
--    [GitHub: hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
--    [TakeTuesday E01: nvim-cmp](https://www.youtube.com/watch?v=_DnmphIwnjo)
--    [Neovim for Beginners — Completion Plugins(https://alpha2phi.medium.com/neovim-for-beginners-completion-plugins-52c46b774474)
--    [Neovim for Beginners — Built-in Completion](https://alpha2phi.medium.com/neovim-for-beginners-built-in-completion-8bbbb0f16c9c)
--    [Neovim - Completion Tutorial 100% Lua](https://www.youtube.com/watch?v=GuIcGxYqaQQ)
--    [Code like a GOD with Neovim AutoComplete and Snippets!](https://www.youtube.com/watch?v=h4g0m0Iwmys)
--    [Completion Sources: Wiki](https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources)
--    [Completion Sources: GitHub Topic](https://github.com/topics/nvim-cmp)
--    [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch/tree/master)
--------------------------------------------------------------------------------

-- if you haven't loaded this plugin, do no operation and return
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  print("'configs/cmp.lua (cmp)' module had an error")
  return
end

--local snip_status_ok, luasnip = pcall(require, 'luasnip')
--if not snip_status_ok then
  --print(''configs/cmp.lua (luasnip)' module had an error')
  --return
--end


-- load vscode like plugins
require('luasnip/loaders/from_vscode').lazy_load()

 -- helps the 'super-tab' function worl
local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

-- icons to supply status information when auto-complition is operating under LSP
-- find more icons here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Text = '󰉿',
	  Method = '󰆧',
	  Function = '󰊕',
	  Constructor = '',
  Field = ' ',
	  Variable = '󰀫',
	  Class = '󰠱',
	  Interface = '',
	  Module = '',
	  Property = '󰜢',
	  Unit = '󰑭',
	  Value = '󰎠',
	  Enum = '',
	  Keyword = '󰌋',
  Snippet = '',
	  Color = '󰏘',
	  File = '󰈙',
  Reference = '',
	  Folder = '󰉋',
	  EnumMember = '',
	  Constant = '󰏿',
  Struct = '',
	  Event = '',
	  Operator = '󰆕',
  TypeParameter = ' ',
	  Misc = ' ',
}

-- setup for auto-completion to make it operational
-- mainly taken from https://github.com/hrsh7th/nvim-cmp#recommended-configuration
-- and https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/cmp.lua
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  -- key mapping when you in the auto-completion function
  mapping = {                                                            -- allows you to scroll through the completion menu
    ['<C-k>'] = cmp.mapping.select_prev_item(),                          -- move up the completion menu
		['<C-j>'] = cmp.mapping.select_next_item(),                          -- move down the completion menu
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),   -- brings up every completion menu for every available option
    ['<C-y>'] = cmp.config.disable,                                      -- specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {                                            -- exit the completion menu
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm { select = true },                    -- confirm the selection from the completion menu and then menu disappears
    ['<Tab>'] = cmp.mapping(function(fallback)                           -- 'super-tab' function
      if cmp.visible() then
        cmp.select_next_item()                                           -- if completion menu is visiable, tab will move to next item
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },

  -- define the layout of the completion menu
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])                   -- this concatenates the icons with the name of the item kind
      --vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- this concatenates the icons with the name of the item kind
      vim_item.menu = ({           -- see 'sources' below
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        buffer = '[Buffer]',
        path = '[Path]',
        --treesitter = '[Treesitter]',
        --nvim_lua = '[Lua]',
        --spell = '[Spell]',
        --emoji = '[Emoji]',
        --calc = '[Calc]',
      })[entry.source.name]
      return vim_item
    end,
  },

  -- this identifies the extensions (aka sources) for your auto-completions
  -- the order implies the precedence of how the snippets are presented
  -- completion sources reference names: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources and https://github.com/topics/nvim-cmp
  -- https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver)
  sources = {
    { name = 'nvim_lsp' },         -- for plugin hrsh7th/cmp-nvim-lsp - neovim's built-in LSP client completion source
    { name = 'luasnip' },          -- for plugin saadparwaiz1/cmp_luasnip - luasnip completion source
    { name = 'buffer' },           -- for plugin hrsh7th/cmp-buffer - buffer words
    { name = 'path' },             -- for plugin hrsh7th/cmp-path - paths of files and folders
    --{ name = 'treesitter' },       -- for plugin ray-x/cmp-treesitter - treesitter nodes
    --{ name = 'nvim_lua' },         -- for plugin hrsh7th/cmp-nvim-lua - neovim's lua api
    --{ name = 'spell' },            -- for plugin f3fora/cmp-spell - vim's spell suggest
    --{ name = 'emoji' },            -- for plugin hrsh7th/cmp-emoji - markdown emojis
    --{ name = 'calc' },             -- for plugin hrsh7th/cmp-calc - evaluating mathematical expressions
},


  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    documentation = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
  },

  experimental = {
    ghost_text = true,             -- true provides the full string of the but using lighter font
    native_menu = false,
  },
}

