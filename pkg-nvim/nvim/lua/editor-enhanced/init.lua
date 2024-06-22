
--[[----------------------------------------------------------------------------
editor-advanced/init.lua

This file is your entry point for the namespace 'editor-basic'.  It will be
responsible for importing additional Lua modules as needed by this namespace.

Sources:
      [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
----------------------------------------------------------------------------]]--


-- core/foundational modules for neovim configuration
require('options')                                                              -- assign values to options
require('autocommands')                                                         -- setup neovim automation
require('plugins')                                                              -- load neovim plugins
require('keymappings')                                                          -- establish key mappings using the plugin 'folke/which-key.nvim'
