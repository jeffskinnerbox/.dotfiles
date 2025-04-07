-- luacheck: globals vim
-- luacheck: max line length 300

--[[ entry point for all the nvim instances

  Description:
    This file is your entry point for all the nvim instances.  It will be used to:
      1. Establish options that are required before everything else
      2. Import additional Lua modules as needed, specifically the namespaces
         for the different version of nvim editors created (e.g. editor-basic, editor-ehnanced, etc.)

    It is critical that the Lua files be place in the following configuration.
    If not, nvim may still execute but some or all of the Lua file will not
    take effect.

    The NeoVim file structure for the 'active' implementation is shown below
    (using `tree -a --filesfirst ~/.dotfiles/pkg-nvim/nvim/lua/active/`):

      $HOME/.dotfiles/pkg-nvim/nvim/lua/active/
        ├── init.lua
        ├── lazy-lock.json
        ├── .luacheckrc
        ├── .markdownlint.json
        ├── README.md
        ├── docs
        │   └── LICENSE.md
        └── lua
            ├── lazy-loader.lua
            ├── README.md
            ├── after
            │   └── ftplugins
            │       ├── arduino.lua
            │       ├── cpp.lua
            │       ├── filetypes.lua
            │       ├── init.lua
            │       ├── lua.lua
            │       ├── markdown.lua
            │       ├── python.lua
            │       ├── README.md
            │       └── sh.lua
            ├── core
            │   ├── autocommands.lua
            │   ├── commands.lua
            │   ├── health.lua
            │   ├── init.lua
            │   ├── keymaps.lua
            │   ├── options.lua
            │   └── README.md
            └── plugins
                ├── alpha-nvim.lua
                ├── auto-session.lua
                ├── bufferline.lua
                ├── catppuccin.lua
                ├── ccc.lua
                ├── comment.lua
                ├── dressing.lua
                ├── flash.lua
                ├── gitsigns.lua
                ├── harpoon.lua
                ├── indent-blankline.lua
                ├── kanagawa.lua
                ├── kiwi.lua
                ├── lazygit.lua
                ├── lualine.lua
                ├── markdown-preview.lua
                ├── maximizer.lua
                ├── mini.lua
                ├── neo-tree.lua
                ├── neovim-project.lua
                ├── neovim-session-manager.lua
                ├── noice.lua
                ├── nvim-autopairs.lua
                ├── nvim-cmp.lua
                ├── nvim-colorizer.lua
                ├── nvim-silicon.lua
                ├── nvim-tree.lua
                ├── nvim-treesitter.lua
                ├── obsidian.lua
                ├── project.lua
                ├── README.md
                ├── taskwiki.lua
                ├── telescope.lua
                ├── tint.lua
                ├── todo-comments.lua
                ├── toggleterm.lua
                ├── tokyonight.lua
                ├── trouble.lua
                ├── url-open.lua
                ├── virt-column.lua
                ├── which-key.lua
                ├── dap
                │   ├── nvim-dap.lua
                │   ├── nvim-dap-python.lua
                │   ├── nvim-dap-ui.lua
                │   ├── nvim-dap-virtual-text.lua
                │   └── README.md
                ├── lsp
                │   ├── conform.lua
                │   ├── mason.lua
                │   ├── nvim-lint.lua
                │   ├── nvim-lspconfig.lua
                         │   └── README.md
                └── vim
                    ├── suda.lua
                    └── vimwiki.lua

  Make sure the '~/.config/nvim/init.lua' file points to the appropriate
  '~/.config/nvim/lua/*' directory (aka namespace).  If not, nvim might run
  but without the appropriate effects from the Lua files.

  Sources:
    [CheckHealth in Neovim](http://vimcasts.org/episodes/neovim-checkhealth/)
    [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
    [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/)
]]
--

-- entry point for all the nvim instances, uncomment ONLY one
require("active")
--require('experimental')
--require('lazyvim')
