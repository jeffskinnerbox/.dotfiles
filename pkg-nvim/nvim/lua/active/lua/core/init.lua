-- luacheck: globals vim
-- luacheck: max line length 300

-- Manual Load Modules
-- these modules were manually created and are not within github repositories
--require("lua.core.options")                                                     -- set the other neovim options (aka settings, variables)
--require("lua.core.keymaps")                                                     -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
--require("lua.core.autocommands")
--require('health')
require("core.options")                                                     -- set the other neovim options (aka settings, variables)
require("core.keymaps")                                                     -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
require("core.autocommands")
require('core.health')
--require("options")                                                     -- set the other neovim options (aka settings, variables)
--require("keymaps")                                                     -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
--require("autocommands")
--require('health')

