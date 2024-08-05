-- vim: set ts=2 sw=2 sts=2 et ai:                                              -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=lua:'

-- luacheck: globals vim
-- luacheck: max line length 300

-- Manual Load Modules
-- these modules were manually created and are not within github repositories
require("lua.core.options")                                                     -- set the other neovim options (aka settings, variables)
require("lua.core.keymaps")                                                     -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
require("lua.core.autocommands")
require('lua.core.health')

