-- luacheck: globals vim
-- luacheck: max line length 300

-- Manual Load Modules                                                          -- these modules were manually created and are not within github repositories
require("core.options")                                                         -- set the other neovim options (aka settings, variables)
require("core.keymaps")                                                         -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
require("core.commands")
require("core.autocommands")
require("core.health")

