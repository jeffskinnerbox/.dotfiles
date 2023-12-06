
--------------------------------------------------------------------------------
-- editor-enhanced/plugins.lua

-- This file enhanses the NeoVim functionality by providing 'drop-in' code to
-- accomplish specific tasks.  These plugins are managed via a plugin called
-- 'Packer'. The plugin code is extracted from GitHub and loaded into the
-- `$HOME/.config/nvim` directory.

--   :PackerCompile        -- run this or `PackerSync` whenever you make changes to your plugin configuration so you regenerate compiled loader file
--   :PackerClean          -- remove any disabled or unused plugins
--   :PackerInstall        -- clean, then install missing plugins
--   :PackerUpdate         -- clean, then update and install plugins
--   :PackerSync           -- perform `PackerUpdate` and then `PackerCompile`
--   :PackerStatus         -- show list of installed plugins

-- NOTE:
--   (1) You might need to run `:PackerSync` whenever you make changes
--       to your plugin configuration.
--   (2) Sometime necessary to start with a complete refresh by first
--       doing the following:
--       trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo/ \
--             ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin

-- Sources:
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
  local config_path = vim.fn.stdpath('config')
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer.  You should close and reopen Neovim...")
    vim.cmd[[packadd packer.nvim]]
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
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- have packer use a popup window to show status
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})


--------------------------------------------------------------------------------
-- Install and configure all your plugins here
--------------------------------------------------------------------------------
return require('packer').startup(function(use)

---- packer is a plugin package management -------------------------------------
  use { 'wbthomason/packer.nvim' }        -- packer package manager can manage itself
  use { 'nvim-lua/popup.nvim' }           -- an implementation of the popup api from vim in neovim

---- manage theme & color scheme -----------------------------------------------
  use { 'folke/tokyonight.nvim' }         -- written in Lua, with support for lsp, treesitter, and lots of plugins
  --use { 'marko-cerovac/material.nvim' }   -- original material theme now available for neovim
  --use { 'EdenEast/nightfox.nvim' }        -- customizable theme with support for lsp, treesitter, and a variety of plugins
  --use { 'Mofiqul/dracula.nvim' }          -- dracula colorscheme for neovim written in Lua

---- useful utilities used by other plugins ------------------------------------
  use { "nvim-lua/plenary.nvim" }         -- all the lua functions you don't want to write twice
  use { "MunifTanjim/nui.nvim" }          -- user interface component library for neovim

---- nerd font related icons & eye-candy ---------------------------------------
  use { 'nvim-tree/nvim-web-devicons' }

---- user interface command / status line --------------------------------------
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

---- screen formating for easy indentation check -------------------------------
  use { 'lukas-reineke/indent-blankline.nvim' } -- indentation guide-lines

---- user interface for buffer tabs --------------------------------------------
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  --use {'romgrk/barbar.nvim', requires = {    -- tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode
    ----'lewis6991/gitsigns.nvim',             -- optional: for git status
    --'nvim-tree/nvim-web-devicons',           -- optional: for file icons on tabs
  --}}

---- filesystem navigator & file explorer --------------------------------------
  use { 'nvim-tree/nvim-tree.lua',              -- file tree explorer for neovim written in lua
    requires = { 'nvim-tree/nvim-web-devicons', },  -- optional but recommended
    config = function()
      require('nvim-tree').setup{} -- initialized with default settings
    end
  }

---- pop-up terminal emulator --------------------------------------------------
  use { 'akinsho/toggleterm.nvim' }   -- persist & toggle terminals during an editing session

---- quick injection & removal of comments -------------------------------------
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- automatically set-up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
	end
end)

