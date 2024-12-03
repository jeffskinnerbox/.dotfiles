<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

# NeoVim Configuration - Experimental & Active

The version of my NeoVim configuration I call `experimental` is what I'm currently actively developing.
It is where I'm expanding the capabilities of my NeoVim text editor.
Contrast this with the `active` branch of the NeoVim configuration,
where I do no development or bug fixes in an effort to make sure it is always works as expected.
The origin of `active` is a previous version of `experimental`
which has proven itself to be both useful and bug free (to the best of my knowledge!).
So my process is to move my development work on `experimental` into `active`
once it has proven to be stable.

My `.dotfile` is designed so that I can use both `active` and `experimental`
branch of my NeoVim configuration concurrently.
This is important since, if I break the `experimental` version
while making code changes and render it inoperable,
I can always fall back to `active` to fix that problem.
Also, I depend on `active` in my day-to-day work,
leaving the use of `experimental` mainly for it own development & testing.

In this README file, I'm going to describe
how I'm able to operate different NeoVim instances concurrently,
describe how `active` and `experimental` are structured,
touch on some design decisions that I have made,
and cover how I elevate `experimental` to the `active` state.

### Concurrent Operation of NeoVim Instances

### Filesystem Structure

Using command: `tree -a --filesfirst --sort name ~/.dotfiles/pkg-nvim/nvim/lua/experimental/`

/home/jeff/.dotfiles/pkg-nvim/nvim/lua/experimental/
├── init.lua
├── lazy-lock.json
├── .luacheckrc
├── .markdownlint.yaml
├── README.md
├── .yamllint.yaml
├── docs
│   ├── alacritty-tmux-and-neovim.md
│   ├── how-to-use-lsp-framework.md
│   ├── how-to-use-my-neovim.md
│   ├── LICENSE.md
│   ├── neovim-configuration-for-python-development.md
│   ├── nvim-wrapper-function.md
│   ├── project-objectives-and-structure.md
│   ├── second-brain-with-neovim.md
│   ├── setting-up-neovim.md
│   ├── study-plan-for-neovim.md
│   ├── switching-configs-in-neovim.md
│   ├── testing-and-trouble-shotting-neovim-problems.md
│   └── templates
│       ├── .luacheckrc-template
│       ├── lua-file-template.lua
│       ├── .mdlrc-template
│       ├── README-template.md
│       ├── .stow-local-ignore-template
│       └── .stylua-template.toml
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
            ├── vim-better-whitespace.lua
            └── vimwiki.lua

### Elevating 'experimental' to 'active'

Since my `experimental` NeoVim version will eventually become my `active` version,
I need a way to elevate the `experimental` code base into `active`.
How I do this is shown below:

```bash
# remove the old 'active' directory
trash $HOME/.dotfiles/pkg-nvim/nvim/lua/active

# clean out any state or data references to the old version of 'active'
trash $XDG_STATE_HOME/nvim/lua/active $XDG_DATA_HOME/nvim/lua/active

# copy the 'experimental' directory into a new 'active' directory
cp -r $HOME/.dotfiles/pkg-nvim/nvim/lua/experimental $HOME/.dotfiles/pkg-nvim/nvim/lua/active

# build the new active configuration by executing it for the first time
NVIM_APPNAME=nvim/lua/active alacritty-terminal-with-nvim .
# - OR -
vi .
```

Within the `active` instance of NeoVim,
you will want to change the notification of plugin updates since `active` is considered stable.
to do this, goto the `~/.dotfiles/pkg-nvim/nvim/lua/active/lua/lazy-loader.lua` files
and make sure the `require("lazy").setup()` function contains the following:

```lua
  checker = {         -- automatically check for plugin updates and notify the user so they can perform commandline ":Lazy update"
    enabled = true,   -- if 'true', automatically check for plugin updates periodically and inform ":Lazy" command
    notify = false,   -- if 'true', notify user of any updates
  },
```

Once the build step is complete, your good to go.
You can use `active` or `experimental` but make sure to only make changes to the `experimental` version.
But how do you reference the version you want to use or modify?
I'll discuss that next.

### Execution of NeoVim

### Automatic Backups

Backups of the `lazy-lock.json` file are stored in the directory
`$HOME/.local/share/nvim/lua/experimental/plugin-snapshot`
(this is specified in the `autocommands.lua` module).

:BrowseSnapshots              - search for the latest lockfile, grab the commit of the plugin that broke configuration, then copy it to the current lockfile, after that, use the restore command with the name of the plugin
:Lazy restore <plugin-name>   - this will revert the plugin <plugin-name> to the state reflected in the 'lazy-lock.json' lockfile
:Lazy restore                 - this will revert all the plugins to the state reflected in the 'lazy-lock.json' lockfile

### Restoring Backups

Example backup file: `lazy-lock-2024-08-28T22:16:39.json`.

### Dropping Modeline

When I initially created my NeoVim configuration,
I made heavy use of [modeline][04].
modelines allow you to set Vim/NeoVim variables specific to a file.
By default, the first and last five lines are read by vim for variable settings.
For example, I have been using thing like:

```bash
# abrivated version of modeline
vim:ts=2:sw=2:sts=2:et:ai:ft=markdown:

#this modeline is equvalent to the one above
vim:tabstop=2:shiftwidth=2:softtabstop=2:expandtab:autoindent:filetype=markdown:
```

I'm disabling modeline in the `options.lua` file via `vim.opt.modeline = false`.
As I began to more heavily use the modeline function,
I got increasing number of error, trouble with mouse focus, and other mysterious events.
I tried to track down the errors but no success.
My searching of the web produce several articles like this one:
"[How aren't modelines breaking everything??][02]".
I believe I can get similar functionality via "[Vim’s ftplugin system][03]"
so I'm going in that direction now and nolong using modeline.

Sources:

* [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic)
* [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)
* [Adding a Vim modeline in a Markdown document](https://davidjb.com/blog/2016/10/adding-a-vim-modeline-in-a-markdown-document/)
* [Add vim modeline in markdown document](https://stackoverflow.com/questions/53386522/add-vim-modeline-in-markdown-document)

# Installation

Sources:

* [The Best Editor](https://www.youtube.com/watch?v=WgXO2cvmdQc)
* [GitHub: nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
* [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o)
* [From kickstart.nvim to Data Science in 20 minutes](https://www.youtube.com/watch?v=hp7FFr9oM1k)
* [Setup Neovim with kickstart.nvim](https://blog.epheme.re/software/nvim-kickstart.html)

## Add kickstart.nvim to .dotfiles

I followed the procedures outlined in the [nvim-lua/kickstart.nvim README.md file][01]
by first forking the Git repository to `$HOME/src` and then cloning that repository into this location.

```bash
# goto the https://github.com/nvim-lua/kickstart.nvim/tree/master
# OR https://github.com/jeffskinnerbox/kickstart-modular.nvim
# https://github.com/dam9000/kickstart-modular.nvim/tree/master
# and fork the repository via the button on top right

# your forked version of kickstart.nvim is now located here:
# https://github.com/jeffskinnerbox/kickstart.nvim
# forked on June 25, 2024

 move to target directory for the clone and do the clone
# cloned on June 25, 2024
cd $HOME/.dotfiles/pkg-nvim/nvim/lua
git clone https://github.com/jeffskinnerbox/kickstart-modular.nvim.git kickstart
```

## Install Prerequisties

I install the Linux prerequisites for a robust NeoVim installation.
See `$HOME/pkg-nvim/docs/setting-up-neovim.md`.

Basic utils: git, make, unzip, C Compiler (gcc)
ripgrep
Clipboard tool (xclip/xsel/win32yank or other depending on platform)
A Nerd Font: optional, provides various icons
if you have it set vim.g.have_nerd_font in init.lua to true
Language Setup:
If want to write Typescript, you need npm
If want to write Golang, you will need go
etc.

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
````

## Make It Yours

I want to update Kickstart in a minimal way so I can use it with easy but maintain the ordinal functionality.
I will then make updates to this ordinal Kickstart configuration to make it suit my needs.

#### Step 1 - DONE

Make a copy of the ordinal Kickstart configuration (`kickstart` directory).
I did this with the following: `cd $HOME/dotfiles/pkg-nvim/nvim/lua/kickstart ; cp -r kickstart kickstart2`

From here onward, we should work exclusively in the `kickstart2` directory.

#### Step 2 - DONE

In the `init.lua` file,
the custom option `vim.g.have_nerd_font` is set to `false`
but should be set to `true` (e.g. `vim.g.have_nerd_font = true`)
since I'm using Nerd Fonts.

This option is used the files `lua/lazy-plugins.lua`, `lua/kickstart/plugins/telescope.lua`,
and `lua/kickstart/plugins/mini.lua`
for adding icons and loading the `nvim-tree/nvim-web-devicons` plugin.

#### Step 3 - DONE

Set the leader keys options in the `init.lua` file to
`vim.g.mapleader = ','` and `vim.g.maplocalleader = ','`.

#### Step 4

An alternative to the `netrw` filesystem navegator is offered by Kickstart,
just un-comment `require 'kickstart.plugins.neo-tree'`
in file `kickstart2/lua/kickstart/lazy-plugins.lua`.
I'm not a fan of this navigator and I prefer `nvim-tree/nvim-tree.lua`.

To install my prefered filesystem navigation, I must make updates to
`kickstart2/lua/kickstart/lazy-plugins.lua`, `kickstart2/lua/custom/plugins/init.lua`,
`kickstart2/lua/custom/plugins`, `kickstart2/lua/init.lua`:

* In `kickstart2/lua/kickstart/lazy-plugins.lua`, un-comment the line containing `{ import = 'custom.plugins' }`. - DONE
* In `kickstart2/lua/custom/plugins/init.lua`, enter your plugin's GitHub identifier so it can be Lazy loaded. - DONE
* In `kickstart2/lua/custom/plugins` include a file named `nvim-tree.lua` containing the `setup()` for your plugin.
* In `kickstart2/lua/init.lua` file disable NeoVim's native filesystem navicator `netrw` by add `vim.g.loaded_netrw = 1`
  and `vim.g.loaded_netrwPlugin = 1` to top of the `kickstart2/lua/init.lua` file.

#### Step 5

#### Step 6

#### Step 7

---------------

# kickstart-modular.nvim

## Introduction

*This is a fork of [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that moves from a single file to a multi file configuration.*

A starting point for Neovim that is:

* Small
* Modular
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?

  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:

  ```bash
  alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
  ```

  When you run Neovim using `nvim-kickstart` alias it will use the alternative
  config directory and the matching local directory
  `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
  distribution that you would like to try out.

* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
  * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
    * *NOTE: This is the fork that splits the configuration into smaller parts.*
      The original repo with the single `init.lua` file is available here:
  * [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
    * Discussions on this topic can be found here:
  * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
  * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

# Debian Install Steps

```bash
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
do mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```

## LuaCheck Configuration File

LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
If not found, it will look for it in the parent directory and so on,
going up until it reaches file system root.

```lua
-- LuaCheck `.luacheckrc` file

-- LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
-- If not found, it will lggook for it in the parent directory and so on,
-- going up until it reaches file system root. - https://luacheck.readthedocs.io/en/stable/config.html


-- The `std` option allows setting a custom standard set of globals using a table.
-- This table can have two fields: `globals` and `read_globals`.
-- Both of them should contain a field definition map defining some globals.
-- The simplest way to define globals is to list their names:
std = {
   globals = {  },                 -- these globals can be set and accessed
   read_globals = { "vim", }       -- these globals can only be accessed
}

-- suppress complaints about line length unless greater than 300
max_code_line_length = 300

-- filtering warnings using pattern matching on warning codes, variable names, or both
ignore = {  }
```

Sources:

* [LuaCheck Configuration File](https://luacheck.readthedocs.io/en/stable/config.html)

[01]:https://github.com/nvim-lua/kickstart.nvim
[02]:https://www.reddit.com/r/neovim/comments/15qm1zf/how_arent_modelines_breaking_everything/
[03]:https://ejmastnak.com/tutorials/vim-latex/ftplugin/
[04]:https://www.cs.swarthmore.edu/oldhelp/vim/modelines.html
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
