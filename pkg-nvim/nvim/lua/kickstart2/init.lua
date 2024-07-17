-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]


-- these global variables provide overall control of the neovim behavior, make sure to set them before anything else

-- NOTE: disable netrw entirely, if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised), see your options.lua file
-- NOTE: if your using nvim-tree.lua plugin as a replacement for the native 'netrw', disable it at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1                                                          -- disable netrw entirely
vim.g.loaded_netrwPlugin = 1                                                    -- disable netrw entirely

--  NOTE: must happen before keymapping & plugins are loaded (otherwise wrong leader will be active .. very confusing to user)
vim.g.mapleader = ','                                                           -- <space> is the typical leader key, see `:help mapleader`
vim.g.maplocalleader = ','

-- NOTE: set to 'false' if nerd fonts are not installed, this is in case you don't have nerd fonts and you want thing to work anyway
vim.g.have_nerd_font = true                                                     -- set to true if you have a Nerd Font installed and selected in the terminal

-- NOTE: the often active 'autoformatting on save' within formatting can be disruptive to your editing, so lets disable it by default
vim.g.auto_format_on_save = false                                               -- set to true if you wish to autoformat code when saving a buffer to a file


-- startup sequence for neovim to create your custom configuration

require('options')                                                              -- set the other neovim options (aka settings, variables)
require('keymaps')                                                              -- set the key mappings that are not enabled by plugins, plugin enable keymaps will be found in their respective plugin file
require('lazy-bootstrap')                                                       -- boot strap process to bring life to the lazy plugin manager
require('lazy-plugins')                                                         -- now ingest all the plugin files
require('custom.colorscheme')                                                   -- establish your desire color schedule

