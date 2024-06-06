
--------------------------------------------------------------------------------
-- init.lua

-- This file is your entry point for all the nvim instances.  It will be used to:
--      1. Establish options that are required before everything else
--      2. Import additional Lua modules as needed

-- It is critical that the Lua files be place in the following configuration.
-- If not, nvim will still execute but some or all of the Lua file will not
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


-- mapleader has to be set before starts loading any of the plugins
-- default leader is '\', but I prefer ','
vim.g.mapleader = ","               -- ',' is your <leader> character
vim.g.localleader = "\\"            -- <leader> for mappings which are local to a buffer

---- disable netrw at the very start of your init.lua (strongly advised by nivm-tree)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true        -- set termguicolors to enable highlight groups

-- suppress Packer ':CheckHealth' warnings
-- see ':help provider-python', ':help |g:ruby_host_prog' ':help |provider-perl' for more information
--vim.g.loaded_python3_provider = 0   -- suppress warning for no python executable found that can `import neovim`
--vim.g.loaded_ruby_provider = 0      -- suppress warning for `neovim-ruby-host` not found
--vim.g.loaded_node_provider = 0      -- suppress warning for missing "neovim" npm (or yarn, pnpm) package
--vim.g.loaded_perl_provider = 0      -- suppress warning for "Neovim::Ext" cpan module is not installed

-- specify the namespace you wish to use for nvim configuration
--     if you change this, do a full clean-up, requiring a re-install of all plugins
--     trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share
--require('editor-basic')
--require('editor-enhanced')
--require('editor-advanced')
--require('ide-basic')
--require('ide-enhanced')
require('active')

