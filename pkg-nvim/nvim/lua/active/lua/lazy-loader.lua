-- luacheck: globals vim
-- luacheck: max line length 300

--[[ modern plugin manager for Neovim with a powerful UI and a fast startup time

  Description:
    A plugin package manager helps with the installation and overall care of plugins.
    You options for NeoVim plugin management include Vim-Plug, Packer.nvim, and Lazy.nvim.
    To put it simply, Lazy.nvim is a far superior to the others. Checkout
    the videos below to find out why.

      What is Lazyloading? - This is when the loading of a plugin is delayed until a specific event ocures within a plugin or NeoVim.
      What is a Protected Call? - Making a Lua function call just to test for the proper operation of the function.
      What is an Auto Command? - A hunk of code that gets executed when a Vim event happens.
      What is Asynchronous Linting Engine? - This is a linting engine which will only start for a specific file type.

    Plugins can be loaded using a modular approach: using `require 'path/name'` will
    include a plugin definition from file `lua/path/name.lua.

    Plugins can also be added by using a table, with the first argument being
    the link and the following keys can be used to configure plugin behavior/loading/etc.
    e.g. `{ 'numToStr/Comment.nvim', opts = {} }`. You can use `opts = {}` to
    force a plugin to be loaded. This is equivalent to: `require('Comment').setup({})`.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :Lazy show (or just :Lazy)    - show the Lazy mgmt / status window
      :Lazy health                  - runs 'healthcheck' just for Lazy and identifies any configuration issues
      :checkhealth lazy             - runs 'healthcheck' just for Lazy and identifies any configuration issues

    Plugin History
      :Lazy log <plugin-name>       - show the previous github commits, to revert the plugin to any of those commits all I have to do is place the cursor above the commit hash and press 'r'
      :Lazy restore <plugin-name>   - this will revert the plugin <plugin-name> to the state reflected in the 'lazy-lock.json' lockfile
      :Lazy restore                 - this will revert all the plugins to the state reflected in the 'lazy-lock.json' lockfile

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
    [Lazy.nvim: how to revert a plugin back to a previous version](https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp)
    [The Lazy Way in Neovim: From Packer to Lazy.nvim](https://www.youtube.com/watch?v=2ahI8lYUYgw)
    [lazy.nvim - Weekly (Neo)vim Plugin](https://www.youtube.com/watch?v=LCUCN69vw_Q)
    [Lazy.nvim Documentation](https://lazy.folke.io/)
]]


-- Bootstrap Lazy
-- if not already loaded, this extracts lazy.nvim from it github repository place it your directory
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",                                                          -- get the latest stable release of lazy.nvim
    lazyrepo,
    lazypath
  })
  if vim.v.shell_error ~= 0 then                                                -- if git throws an error, report it and stop
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)                                                   -- pre-pend the "lazypath' to the run time path (aka 'rtp')


require("lazy").setup({
  { import = "plugins" },                                                       -- import and lazy load lua plugins that neivim functional capabilities
  { import = "plugins.lsp" },                                                   -- import and lazy load lua plugins that implement lsp support
  { import = "plugins.dap" },                                                   -- import and lazy load lua plugins that implement debugging
  { import = "plugins.vim" },                                                   -- import and lazy load plugins that are written in vim script
  }, {
  defaults = {
    lazy = false,                                                               -- by default, only LazyVim plugins will be lazy-loaded, Your custom plugins will load during startup, if you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default
    version = false,                                                            -- always use the latest git commit, it's recommended to leave 'version = false' for now, since a lot the plugin that support versioning, have outdated releases, which may break your Neovim install
    --version = "*",                                                            -- try installing the latest stable version for plugins that support semver
  },
  checker = {                                                                   -- automatically check for plugin updates and notify the user so they can perform commandline ":Lazy update"
    enabled = true,                                                             -- if 'true', automatically check for plugin updates periodically and inform ":Lazy" command
    notify = false,                                                             -- if 'true', notify user of any updates
  },
  change_detection = {
    notify = false,                                                             -- turn off notifications whenever plugin changes are made
  },
--[[
  ui = {
    -- if you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
]]--
})

