
--------------------------------------------------------------------------------
-- -editor-basic/plugins.lua

-- This file enhances the NeoVim functionality by providing 'drop-in' code to
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
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Bootstrap the installation of Packer.nvim
--------------------------------------------------------------------------------
-- if Packer is absent, automatically install and set up packer.nvim
local ensure_packer = function()
print(ensure_packer)
  local install_path = vim.fn.stdpath('config')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd[[packadd packer.nvim]]
    print("Installing Packer. You should close & reopen Neovim ...")
    return true
  end
  return false
end

-- flag to trigger 'packersync' if packer was installed
local packer_bootstrap = ensure_packer()

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- have packer use a pop-up window for status
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


--------------------------------------------------------------------------------
-- Install and configure all you plugins hear
--------------------------------------------------------------------------------
-- install your plugins here
return require('packer').startup(function(use)
    -- all plugins go here
    use 'wbthomason/packer.nvim'        -- Packer package manager can manage itself
    use 'xiyaowong/virtcolumn.nvim'     -- display a character at the colorcolumn to recommend line length
    use 'itchyny/lightline.vim'         -- configurable status-line / tab-line

  -- automatically set-up your configuration after packer.nvim install
  if packer_bootstrap then
    require('packer').sync()
	end
end)

