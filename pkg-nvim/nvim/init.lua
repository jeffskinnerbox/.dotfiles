
--------------------------------------------------------------------------------
-- init.lua

-- This file is your entry point for all the nvim instances.  It will be used to:
--      1. Establish options that are required before everything else
--      2. Import additional Lua modules as needed, specifically the namespaces
--         for the different version of nvim editors created (e.g. editor-basic, editor-ehnanced, etc.)

-- It is critical that the Lua files be place in the following configuration.
-- If not, nvim may still execute but some or all of the Lua file will not
-- take effect.

-- The NeoVim file structure for the 'active' implementation is shown below

--      ~/.config/nvim/
--      ├── init.lua
--      ├── lua
--      │   ├── active
--      │   │   ├── autocommands.lua
--      │   │   ├── configs
--      │   │   │   ├── barbar.lua
--      │   │   │   ├── bufferline.lua
--      │   │   │   ├── comment.lua
--      │   │   │   ├── indent-blankline.lua
--      │   │   │   ├── lualine.lua
--      │   │   │   ├── material.lua
--      │   │   │   ├── nvim-tree.lua
--      │   │   │   ├── nvim-web-devicons.lua
--      │   │   │   ├── toggleterm.lua
--      │   │   │   ├── tokyonight.lua
--      │   │   ├── init.lua
--      │   │   ├── keymappings.lua
--      │   │   ├── plugins.lua
--      │   │   └── settings.lua
--      │   ├── <other namespaces>
--      ├── plugin
--      │   └── packer_compiled.lua
--      ├── swap
--      └── undo

-- Make sure the '~/.config/nvim/init.lua' file points to the appropriate
-- '~/.config/nvim/lua/*' directory (aka namespace).  If not, nvim might run
-- but without the appropriate effects from the Lua files.

-- Sources:
--    [CheckHealth in Neovim](http://vimcasts.org/episodes/neovim-checkhealth/)
--    [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
--    [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/)
--------------------------------------------------------------------------------

--require('trainer')
--require('kickstart')
--require('kickstart-1')
--require('kickstart-2')
--require('nvim-starter-kit')
--require('experimental')
require('active')

