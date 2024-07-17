-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ modern plugin manager for Neovim with a powerful UI and a fast startup time
kickstart2/lua/kickstart/lazy-bootstrap.lua

  Description:
    A plugin package manager helps with the installation and overall care of plugins.
    You options for NeoVim plugin management include Vim-Plug, Packer.nvim, and Lazy.nvim.
    To put it simply, Lazy.nvim is a far superior to the others. Checkout
    the videos below to find out why.

      What is Lazyloading? - This is when the loading of a plugin is delayed until a specific event ocures within a plugin or NeoVim.
      What is a Protected Call? - Making a Lua function call just to test for the proper operation of the function.
      What is an Auto Command? - A hunk of code that gets executed when a Vim event happens.
      What is Asynchronous Linting Engine? - This is a linting engine which will only start for a specific file type.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :Lazy show (or just :Lazy)    - show the Lazy mgmt / status window
      :Lazy health                  - runs 'healthcheck' just for Lazy and identifies any configuration issues
      :checkhealth lazy             - runs 'healthcheck' just for Lazy and identifies any configuration issues

    Within Lazy Popup Status Window
      <shift>+I                     - install any missing plugins
      <shift>+S                     - sync is equivalent to running 'install' + 'clean' + 'update'
      <shift>+U                     - update plugins, this will also update the 'lazy-lock.json' lockfile
      <shift>+X                     - clear out plugins that are no longer needed
      <shift>+C                     - check for GitHub updates and show the log (aka 'git fetch')
      <shift>+L                     - show the git change log for the most recent updates
      <shift>+R                     - updates all plugins to the state in the 'lazy-lock.json' lockfile, for a single plugin restore it to the state in the lockfile or to a given commit under the cursor
      <shift>+P                     - show the plugin loading timeperfromance profile
      <shift>+D                     - show debug information for when things go wrong
      <shift>+?                     - help information when things go wrong

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: folke/lazy.nvim](https://github.com/folke/lazy.nvim)
    [How To Use lazy.nvim For A Simple And Amazing Neovim Config](https://www.youtube.com/watch?v=6mxWayq-s9I)
    [Ultimate Neovim Setup Guide: lazy.nvim Plugin Manager](https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7)
    [The Lazy Way in Neovim: From Packer to Lazy.nvim](https://www.youtube.com/watch?v=2ahI8lYUYgw)
    [lazy.nvim - Weekly (Neo)vim Plugin](https://www.youtube.com/watch?v=LCUCN69vw_Q)
    [Lazy.nvim Documentation](https://lazy.folke.io/)
]]

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  --{ 'numToStr/Comment.nvim', opts = {} },   -- replace with the 'lickstart2/custom/plugins/comment.lua' file

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/nvim-cmp',

  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.nvim-lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  -- Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

