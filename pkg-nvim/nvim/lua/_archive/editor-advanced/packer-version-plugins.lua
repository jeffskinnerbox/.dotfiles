
--------------------------------------------------------------------------------
-- editor-advanced/plugins.lua

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
--   (1) You might need to run `:PackerSync` whenever you make changes
--       to your plugin configuration.
--   (2) Sometime necessary to start with a complete refresh by first
--       doing the following:
--       trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo/ \
--             ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin

-- Sources:
--    [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
--    [Neovim plugins w/ Packer](https://www.chiarulli.me/Neovim-2/03-plugins/)
--    [packer.nvim - Quick Start](https://github.com/wbthomason/packer.nvim#quickstart)
--    [Neovim-from-scratch/lua/user/plugins.lua](https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/plugins.lua)
--    [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
--    [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
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

---- packer is a plugin package management -------------------------------------
  use { 'wbthomason/packer.nvim' }                  -- packer package manager can manage itself

---- manage theme & color scheme -----------------------------------------------
  use { 'navarasu/onedark.nvim' }                   -- written in lua based on Atom's One Dark and Light theme

---- useful utilities used by other plugins ------------------------------------
  use { 'nvim-lua/popup.nvim' }                     -- an implementation of the pop-up api from vim in neovim
  use { 'MunifTanjim/nui.nvim' }                    -- user interface component library for neovim
  use { 'nvim-lua/plenary.nvim' }                   -- all the lua functions you don't want to write twice
  use { 'nvim-tree/nvim-web-devicons' }             -- nerd font related icons & eye-candy

---- user interface command / status line / window bar -------------------------
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }

---- user interface for buffer tabs --------------------------------------------
  use {'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons'}

---- screen formating for ease of use ------------------------------------------
  use { 'lukas-reineke/indent-blankline.nvim' }     -- indentation guide-lines
  use { 'sitiom/nvim-numbertoggle' }                -- automatically toggle between relative and absolute line numbers

---- filesystem navigator & file explorer --------------------------------------
  use { 'nvim-tree/nvim-tree.lua',                  -- file tree explorer for neovim written in lua
    requires = { 'nvim-tree/nvim-web-devicons', },  -- optional but recommended
    config = function()
      require('nvim-tree').setup{}                  -- initialized with default settings, override as needed later
    end
  }

---- toggleterm - pop-up terminal emulator -------------------------------------
  use { 'akinsho/toggleterm.nvim' }                 -- persist & toggle terminals during an editing session

---- comments - quick injection & removal of comments --------------------------
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()                    -- initialized with default settings, override as needed later
    end
  }

---- telescope - a fuzzy finder over lists -------------------------------------
  use { 'nvim-telescope/telescope.nvim',            -- highly extendable fuzzy finder over lists
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-telescope/telescope-file-browser.nvim',  -- file browser extension for telescope
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  }

---- treesitter - syntax highlighting ------------------------------------------
  --vim.opt.syntax = "on"                             -- enable nvim native syntax highlighting if you are NOT using treesitter - set nvim native syntax highlighting to 'off' (vim.opt.syntax = 'off') when using treesitter
  use { 'nvim-treesitter/nvim-treesitter',          -- tree-sitter is a parser generator tool and an incremental parsing library.  nvim-treesitter provide some basic functionality such as highlighting
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }

---- which-key - popup with possible key bindings ------------------------------
  use { 'folke/which-key.nvim',                     -- displays a pop-up with possible key bindings of the command you started typing
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500                        -- popup wait time for a mapped sequence to complete, in milliseconds (default 1000)
      require('which-key').setup()                  -- initialized with default settings, override as needed later
    end,
  }

---- markdown-preview - preview markdown on your modern browser ----------------
  use { 'iamcco/markdown-preview.nvim',             -- preview markdown on your modern browser with synchronised scrolling
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  }

---- nvim-colorizer - colors preview and slection ------------------------------
  use { 'NvChad/nvim-colorizer.lua' }               -- color highlighter for color codes and names


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


---- plugins for useful tools --------------------------------------------------
  --use { 'lewis6991/gitsigns.nvim',  -- git
      --config = function()
          --require('configs.gitsigns')
      --end,
  --}

---- source code control - git integration -------------------------------------
--https://alpha2phi.medium.com/neovim-for-beginners-source-code-control-71139e4513a1
--https://www.youtube.com/watch?v=F7JZdAwGmpU&t=63s
--https://github.com/dinhhuy258/git.nvim

---- Python Debugging & Testing Setup -----------------------------------------
-- [LunarVim as a Python IDE | Pyright | Black Formatting | Flake8 Linting | Virtual ENV Switching](https://www.youtube.com/watch?v=lUssfjNzGNg&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6&index=6)
-- [LunarVim | Debugging & Testing Python Setup](https://www.youtube.com/watch?v=onu_upaLKo4&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6&index=7)
-- []()

---- Language Server Protocol (LSP) --------------------------------------------
  -- [Neovim 101 — LSP](https://alpha2phi.medium.com/neovim-101-lsp-780b44e2dc96)
  -- [Neovim - Native LSP Setting Up Autocomplete and Language Servers](https://www.youtube.com/watch?v=NXysez2vS4Q)
  -- https://www.barbarianmeetscoding.com/notes/neovim-plugins/#language-server-protocol
  -- https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/
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
  ---- https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451
  --use { "neovim/nvim-lspconfig",
    --wants = {
      ---- "nvim-lsp-installer",
      --"mason.nvim",                   -- allows us to easily manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface
      --"mason-lspconfig.nvim",         -- extension of mason.nvim that bridges mason.nvim with the nvim-lspconfig plugin, making it easier to use both plugins together
      --"mason-tool-installer.nvim",    -- plugin that helps to install or upgrade all of the third-party tools
    --},
    --config = function()
      --require("config.lsp").setup()           -- initialized with default settings, override as needed later
    --end,
    --requires = {
      ---- "williamboman/nvim-lsp-installer",
      --"williamboman/mason.nvim",
      --"williamboman/mason-lspconfig.nvim",
      --"WhoIsSethDaniel/mason-tool-installer.nvim",
  --}
  --use { 'onsails/lspkind-nvim' }
  --use { 'L3MON4D3/LuaSnip',
      --tag = 'v<CurrentMajor>.*',    -- follow latest release
  --}

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

---- code snippets -------------------------------------------------------------
--https://alpha2phi.medium.com/neovim-for-beginners-snippets-450a855584f8
--https://github.com/dcampos/nvim-snippy
--https://github.com/hrsh7th/vim-vsnip

---- AI assisted coding --------------------------------------------------------
--[Modern Neovim — AI Coding](https://alpha2phi.medium.com/modern-neovim-ai-coding-f1eef8fe829a)
--[Autocompletion in Neovim using Github Copilot -- I think I love it](https://www.youtube.com/watch?v=6vBKe2mI_9c)

---- terminal debugger ---------------------------------------------------------
  -- [How to debug like a PRO using Neovim](https://miguelcrespo.co/how-to-debug-like-a-pro-using-neovim)
  -- [debugging via 'print()' statement to trace the output during execution](https://github.com/andrewferrier/debugprint.nvim)
  -- https://alpha2phi.medium.com/neovim-for-beginners-terminal-debugger-77e48428378d
  -- https://www.dannyadam.com/blog/2019/05/debugging-in-vim/
  -- https://harrisoncramer.me/debugging-in-neovim/
  -- https://www.youtube.com/watch?v=0moS8UHupGc

---- framework for testing -----------------------------------------------------
-- [Neovim DAP Enhanced](https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b)
-- [GitHub: nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)
-- [Debugging Neovim with Neovim and nvim-dap](https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/)
-- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
-- [Neovim for Beginners — Testing (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-testing-part-2-10d4aa8f25d6)
-- [vimspector - A multi language graphical debugger for Vim](https://puremourning.github.io/vimspector-web/)
-- [Integrated Test Results in Neovim](https://www.youtube.com/watch?v=cf72gMBrsI0)

---- creating plugins ---------------------------------------------------------
--[]Vim/Neovim: Scripting using Python(https://alpha2phi.medium.com/vim-neovim-scripting-using-python-c7e6d062aeaa)


  -- automatically set-up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
	end
end)

