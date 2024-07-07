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

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath) -- prepend the 'lazypath' to the run time path (aka 'rtp')

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
