
--------------------------------------------------------------------------------
-- active/plugins.lua

-- This file enhanses the NeoVim functionality by providing 'drop-in' code to
-- accomplish specific tasks.  These plugins are managed via a plugin called
-- 'Packer'. The plugin code is extracted from GitHub and loaded into the
-- `$HOME/.config/nvim` directory.

-- Commandline:
--    :PackerCompile     - run this or `PackerSync` whenever you make changes to your plugin configuration so you regenerate compiled loader file
--    :PackerClean       - remove any disabled or unused plugins
--    :PackerInstall     - clean, then install missing plugins
--    :PackerUpdate      - clean, then update and install plugins
--    :PackerSync        - perform `PackerUpdate` and then `PackerCompile`
--    :PackerStatus      - show list of installed plugins

-- NOTE:
--    1. You might need to run `:PackerSync` whenever you make changes
--       to your plugin configuration.
--    2. Sometime necessary to start with a complete refresh by first
--       doing the following:
--       trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo/ \
--             ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin

-- Sources:
--    [GitHub: wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
--    [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
--    [Neovim plugins w/ Packer](https://www.chiarulli.me/Neovim-2/03-plugins/)
--    [Neovim-from-scratch/lua/user/plugins.lua](https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/plugins.lua)
--    [How to Set up Neovim for Windows and Linux with Lua and Packer](https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391)
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Bootstrap the installation of Packer.nvim
--------------------------------------------------------------------------------

local ensure_packer = function()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Fresh install of Packer.  You should close & reopen Neovim ...')
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- use a protected call so we don't error out on first use - IMPORTANT!
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

-- have packer use a pop-up window to show status
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})


--------------------------------------------------------------------------------
-- Install and configure all your plugins here
--------------------------------------------------------------------------------
return require('packer').startup(function(use)

---- packer is my plugin for plugin package management -------------------------
  use { 'wbthomason/packer.nvim' }                  -- packer package manager can manage itself and all other plugins

---- plugins to manage theme & color scheme ------------------------------------
  use { 'navarasu/onedark.nvim' }                   -- written in lua based on 'Atom's One Dark and Light' theme

---- useful utilities used by other plugins ------------------------------------
  use { 'nvim-lua/popup.nvim' }                     -- an implementation of the pop-up api from vim in neovim
  use { 'MunifTanjim/nui.nvim' }                    -- user interface component library for neovim
  use { 'nvim-lua/plenary.nvim' }                   -- all the lua functions you don't want to write twice
  use { 'nvim-tree/nvim-web-devicons' }             -- nerd font related icons & eye-candy
  use { 'stevearc/dressing.nvim' }                  -- neovim plugin to improve the default user interfaces (vim.ui)

---- user interface for commandaline / status line / buffer tabs ---------------
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use {'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons'}

---- screen formatting with indentation guides and line numbering --------------
  use { 'lukas-reineke/indent-blankline.nvim' }     -- indentation guide-lines
  use { 'sitiom/nvim-numbertoggle' }                -- automatically toggle between relative and absolute line numbers

---- hierarchical filesystem navigator & file explorer -------------------------
  use { 'nvim-tree/nvim-tree.lua',                  -- file tree explorer for neovim written in lua
    requires = { 'nvim-tree/nvim-web-devicons', },  -- optional but recommended
    config = function()
      require('nvim-tree').setup{}                  -- initialized with default settings, override as needed later
    end
  }

---- pop-up persistent terminal emulator ---------------------------------------
  use { 'akinsho/toggleterm.nvim' }                 -- persist & toggle terminals during an editing session

---- quick injection & removal of comments on lines or blocks ------------------
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()                    -- initialized with default settings, override as needed later
    end
  }

---- use fzf-like fuzzy finder over lists & buffers ----------------------------
  use { 'nvim-telescope/telescope.nvim',            -- highly extendable fuzzy finder over lists
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-telescope/telescope-file-browser.nvim',  -- file browser extension for telescope
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  }

---- treesitter parser for syntax highlighting ---------------------------------
  --vim.opt.syntax = 'on'                             -- enable nvim native syntax highlighting if you are NOT using treesitter - set nvim native syntax highlighting to 'off' (vim.opt.syntax = 'off') when using treesitter
  --use { 'nvim-treesitter/nvim-treesitter',          -- tree-sitter is a parser generator tool and an incremental parsing library.  nvim-treesitter provide some basic functionality such as highlighting
      --run = function()
          --local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          --ts_update()
      --end,
  --}
  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- tree-sitter is a parser generator tool and an incremental parsing library.  nvim-treesitter provide some basic functionality such as highlighting
  use { 'nvim-treesitter/nvim-treesitter',          -- tree-sitter is a parser generator tool and an incremental parsing library.  nvim-treesitter provide some basic functionality such as highlighting
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
---- popup a menu with possible key bindings as keys are typed -----------------
  use { 'folke/which-key.nvim',                     -- displays a pop-up with possible key bindings of the command you started typing
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500                        -- popup wait time for a mapped sequence to complete, in milliseconds (default 1000)
      require('which-key').setup()                  -- initialized with default settings, override as needed later
    end,
  }

---- as you edit text, synchronously preview markdown on your modern browser ---
  use { 'iamcco/markdown-preview.nvim',             -- preview markdown on your modern browser with synchronised scrolling
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  }

---- colors previewer and selection for highlighting ---------------------------
  use { 'NvChad/nvim-colorizer.lua' }               -- preview and selection of color codes / names for color highlighting

---- pop-up color picker for color code text strings ---------------------------
  use { 'uga-rosa/ccc.nvim' }                       -- pop-up color picker for color code text strings

---- icon picker helps you pick nerd font icons, symbols & emojis --------------
  use { 'ziontee113/icon-picker.nvim',              -- popup picker for nerd font icons, symbols, and emojis
    config = function()
      require('icon-picker').setup {
        disable_legacy_commands = true
      }
    end,
    requires = { 'nvim-telescope/telescope.nvim', 'stevearc/dressing.nvim' }
  }

---- pop-up error and status notification --------------------------------------
  use { 'rcarriga/nvim-notify' }
  --use { 'rcarriga/nvim-notify',
    --event = "BufReadPre",
    --config = function()
      --require('configs.nvim-notify').setup()
    --end,
  --}

---- - git status for file/directories and 'lazygit' integration ---------------
  use { 'lewis6991/gitsigns.nvim' }                 -- show adds/removes/changes and interact with git
  use { 'kdheepak/lazygit.nvim',                    -- plugin for calling lazygit from within neovim
      requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', },
      config = function()
          require('telescope').load_extension('lazygit')
      end,
  }

---- auto-pairing so to add surrounding delimiter pairs ------------------------
  use { 'windwp/nvim-autopairs',         -- use this if you are NOT using nvim-cmp
      config = function() require('nvim-autopairs').setup {} end
  }
  --use { 'windwp/nvim-autopairs',         -- use this if you ARE using nvim-cmp
    --wants = 'nvim-treesitter',
    --module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
    --config = function()
      --require('config.autopairs').setup()
    --end,
  --}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- [Learn Neovim The Practical Way](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
-- [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
-- [LunarVim Advanced Pyright LSP Configuration & Usage](https://medium.com/@chrisatmachine/lunarvim-advanced-pyright-lsp-configuration-usage-665a14decb77)
-- [Neovim for Beginners — LSP Installer](https://alpha2phi.medium.com/neovim-for-beginners-lsp-installer-245a0326530c)
-- [Neovim modern features: treesitter and LSP](https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/)
-- [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
--    [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------


---- Language Server Protocol (LSP) --------------------------------------------
  --use { 'neovim/nvim-lspconfig' }
  -- [Setup nvim-lspconfig + nvim-cmp](https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/)
  -- [Basic Neovim LSP Setup (with Treesitter and Completion)](https://www.youtube.com/watch?v=Ku-m7eEbWas)
  -- [Neovim LSP, DAP and Fuzzy Finder](https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060)
  -- [legendary.nvim: Execute Keymaps in Vscode's Command Palette Style](https://devctrl.blog/posts/legendary-nvim-execute-keymaps-in-vscodes-command-palette-style/)
  -- [Git-Integration In Neovim](https://medium.com/@shaikzahid0713/git-integration-in-neovim-a6f26c424b58)
  -- [How to set up Neovim 0.5 + Modern plugins (LSP, Treesitter, Fuzzy finder, etc)](https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887)
  -- [Neovim modern features: treesitter and LSP](https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/)
  -- [Neovim 101 — LSP](https://alpha2phi.medium.com/neovim-101-lsp-780b44e2dc96)
  -- [Neovim - Native LSP Setting Up Autocomplete and Language Servers](https://www.youtube.com/watch?v=NXysez2vS4Q)
  -- [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
  -- [0 to LSP : Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
  -- [A Step-by-Step Guide to Configuring LSP in Neovim for Coding in Next.js (React), TypeScript, and TailWindCSS](https://levelup.gitconnected.com/a-step-by-step-guide-to-configuring-lsp-in-neovim-for-coding-in-next-js-a052f500da2#5a4b)
  -- [NEOVIM PLUGINS - ENHANCING YOUR NEOVIM EDITOR WITH AWESOME PLUGINS](https://www.barbarianmeetscoding.com/notes/neovim-plugins/#language-server-protocol)
  -- [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
  -- [Learn How To Use NeoVim As An IDE](https://www.youtube.com/watch?v=H0J1c48NObc)
  -- [Getting Started with Neovim’s LSP](https://raygervais.dev/articles/2021/3/neovim-lsp/)
  -- [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
  -- [Getting started with neovim's native LSP client: The easy way](https://dev.to/vonheikemen/getting-started-with-neovims-native-lsp-client-in-the-year-of-2022-the-easy-way-bp3)
  -- [Make lsp-zero.nvim coexists with other plugins instead of controlling them](https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80)
  -- [Vim C++ – There Is Such a Thing! (Tricks to Use Vim in C++)](https://www.incredibuild.com/blog/vim-c-there-is-such-a-thing-tricks-to-use-vim-in-c)
  -- [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE)
  --use { 'williamboman/mason.nvim',                -- manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface
      --config = function()
          --require('mason').setup()           -- initialized with default settings, override as needed later
      --end,
  --}
   --use { 'williamboman/mason-lspconfig.nvim',     -- extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
      --config = function()
          --require('configs.mason-lsp')
      --end,
  --}
  -- [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
  --use { 'neovim/nvim-lspconfig',
    --wants = {
      ---- 'nvim-lsp-installer',
      --'mason.nvim',                   -- allows us to easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface
      --'mason-lspconfig.nvim',         -- extension of mason.nvim that bridges mason.nvim with the nvim-lspconfig plugin, making it easier to use both plugins together
      --'mason-tool-installer.nvim',    -- plugin that helps to install or upgrade all of the third-party tools
    --},
    --config = function()
      --require('config.lsp').setup()           -- initialized with default settings, override as needed later
    --end,
    --requires = {
      ---- 'williamboman/nvim-lsp-installer',
      --'williamboman/mason.nvim',
      --'williamboman/mason-lspconfig.nvim',
      --'WhoIsSethDaniel/mason-tool-installer.nvim',
  --}

  -- lsp and its support for completion, snippets
  use { 'VonHeikemen/lsp-zero.nvim',              -- a starting point to setup some lsp related features in neovim
    branch = 'v2.x',
    requires = {
      -- lsp support
      { 'neovim/nvim-lspconfig' },                -- setup LSP configurations to communicate between built-in LSP client and external servers
      { 'williamboman/mason.nvim', run = ':MasonUpdate' }, -- install and manage LSP servers, DAP servers, linters, and formatters - allows you to easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface (optional)
      { 'williamboman/mason-lspconfig.nvim' },    -- bridges mason.nvim with the nvim-lspconfig plugin - making it easier to use both plugins together (optional)

      -- engine for completion & suggestions as we type
      { 'hrsh7th/nvim-cmp' },                     -- completion engine

      -- completion source data
      { 'hrsh7th/cmp-buffer' },                   -- nvim-cmp completion source for neovim buffers
      { 'hrsh7th/cmp-path' },                     -- nvim-cmp completion source for neovim paths
      { 'hrsh7th/cmp-cmdline' },                  -- nvim-cmp completion source for neovim commandline
      { 'saadparwaiz1/cmp_luasnip' },             -- nvim-cmp completion source for snippits
      { 'hrsh7th/cmp-nvim-lsp' },                 -- nvim-cmp completion source for LSP client
      {'hrsh7th/cmp-nvim-lua'},                   -- nvim-cmp completion source will complete neovim's Lua runtime API such 'vim.lsp.*'

      -- snippets support
      --{ 'L3MON4D3/LuaSnip' },                     -- snippit engine
      { "L3MON4D3/LuaSnip", run = "make install_jsregexp" },    -- snippit engine

      -- snippets source data
      { 'rafamadriz/friendly-snippets' },         -- a bunch of snippets for multiple languages
    }
  }

---- LSP diagnostics, code actions, and more via Lua ---------------------------
  --use { 'jose-elias-alvarez/null-ls.nvim',
      --config = function()
          --require('configs.null-ls')
      --end,
      --requires = { 'nvim-lua/plenary.nvim' },
  --}

---- autocomplete --------------------------------------------------------------
-- [Code like a GOD with Neovim AutoComplete and Snippets!](https://www.youtube.com/watch?v=h4g0m0Iwmys)
  --use { 'nvim-lua/completion-nvim' }
  --use { 'hrsh7th/nvim-cmp',
    --event = 'InsertEnter',
    --config = function() require('configs.cmp')
        --end,
  --}
  --use('hrsh7th/cmp-nvim-lsp')
  --use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
  --use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })

---- AI assisted coding --------------------------------------------------------
--[Modern Neovim — AI Coding](https://alpha2phi.medium.com/modern-neovim-ai-coding-f1eef8fe829a)
--[Autocompletion in Neovim using Github Copilot -- I think I love it](https://www.youtube.com/watch?v=6vBKe2mI_9c)
--[Better than Copilot? This AI plugin for Neovim is Incredible](https://www.youtube.com/watch?v=7k0KZsheLP4)

---- terminal debugger ---------------------------------------------------------
  -- [How to debug like a PRO using Neovim](https://miguelcrespo.co/how-to-debug-like-a-pro-using-neovim)
  -- [debugging via 'print()' statement to trace the output during execution](https://github.com/andrewferrier/debugprint.nvim)
  -- https://alpha2phi.medium.com/neovim-for-beginners-terminal-debugger-77e48428378d
  -- https://www.dannyadam.com/blog/2019/05/debugging-in-vim/
  -- https://harrisoncramer.me/debugging-in-neovim/
  -- https://www.youtube.com/watch?v=0moS8UHupGc
  -- [Write Better in Neovim With Languagetool](https://www.rockyourcode.com/write-better-in-neovim-with-languagetool/)

---- framework for testing -----------------------------------------------------
-- [Modern Neovim— Debugging and Testing](https://alpha2phi.medium.com/modern-neovim-debugging-and-testing-8deda1da1411)
-- [Neovim DAP Enhanced](https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b)
-- [GitHub: nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)
-- [Debugging Neovim with Neovim and nvim-dap](https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/)
-- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
-- [Neovim for Beginners — Testing (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-testing-part-2-10d4aa8f25d6)
-- [vimspector - A multi language graphical debugger for Vim](https://puremourning.github.io/vimspector-web/)
-- [Integrated Test Results in Neovim](https://www.youtube.com/watch?v=cf72gMBrsI0)

---- framework for data science ------------------------------------------------
-- [Neovim PDE for Data Science](https://alpha2phi.medium.com/neovim-pde-for-data-science-e1cc4c82a424)
-- [Neovim PDE for Data Science (Part 2](https://alpha2phi.medium.com/neovim-pde-data-science-part-2-11433eb6380c)

---- using ChatGPT --------------------------------------------------------------
  -- [Using the ChatGPT.nvim Plugin to Perform Code Readability Analysis in Neovim](https://www.youtube.com/watch?v=zlU3YGGv2zY)
  -- [Writing Neovim Plugins With ChatGPT](https://www.youtube.com/watch?v=sHXQczQHbDk)
  -- [Better than Copilot? This AI plugin for Neovim is Incredible](https://www.youtube.com/watch?v=7k0KZsheLP4)
  -- [jackMort/ChatGPT.nvim](https://github.com/jackmort/chatgpt.nvim)
  -- [How to write better code with ChatGPT](https://bdtechtalks.com/2023/06/26/chatgpt-coding-tips/?utm_source=substack&utm_medium=email)

---- Python Debugging & Testing Setup -----------------------------------------
-- [LunarVim as a Python IDE | Pyright | Black Formatting | Flake8 Linting | Virtual ENV Switching](https://www.youtube.com/watch?v=lUssfjNzGNg&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6&index=6)
-- [LunarVim | Debugging & Testing Python Setup](https://www.youtube.com/watch?v=onu_upaLKo4&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6&index=7)
-- [The perfect Neovim setup for Python](https://www.youtube.com/watch?v=4BnVeOUeZxc&t=84s)

---- code snippets -------------------------------------------------------------
--[LuaSnip](https://www.youtube.com/playlist?list=PL0EgBggsoPCnZ3a6c0pZuQRMgS_Z8-Fnr)
--[Neovim for Beginners — Snippets](https://alpha2phi.medium.com/neovim-for-beginners-snippets-450a855584f8)
--[Neovim setting up snippets with luasnip](https://sbulav.github.io/vim/neovim-setting-up-luasnip/)
--https://github.com/dcampos/nvim-snippy
--https://github.com/hrsh7th/vim-vsnip
 --use { 'onsails/lspkind-nvim' }
  --[TakeTuesday E03: Introduction to LuaSnip](https://www.youtube.com/watch?v=Dn800rlPIho)
  --[TakeTuesday E04: LuaSnips - Advanced Configuration](https://www.youtube.com/watch?v=KtQZRAkgLqo)
  --use { 'L3MON4D3/LuaSnip',
      --tag = 'v<CurrentMajor>.*',    -- follow latest release
  --}

---- creating plugins ---------------------------------------------------------
--[]Vim/Neovim: Scripting using Python(https://alpha2phi.medium.com/vim-neovim-scripting-using-python-c7e6d062aeaa)


  -- automatically set-up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
	end
end)



