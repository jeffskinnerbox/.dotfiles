<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
<!-- markdownlint-disable-file MD007 MD012 MD013 MD022 MD033 MD035 MD041 MD045          -- for the linter 'markdownlint', disable these linting rule, See [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---

# Installation

Sources:

- [The Best Editor](https://www.youtube.com/watch?v=WgXO2cvmdQc)
- [GitHub: nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o)
- [From kickstart.nvim to Data Science in 20 minutes](https://www.youtube.com/watch?v=hp7FFr9oM1k)
- [Setup Neovim with kickstart.nvim](https://blog.epheme.re/software/nvim-kickstart.html)

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

# move to target directory for the clone and do the clone
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
```

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

- In `kickstart2/lua/kickstart/lazy-plugins.lua`, un-comment the line containing `{ import = 'custom.plugins' }`. - DONE
- In `kickstart2/lua/custom/plugins/init.lua`, enter your plugin's GitHub identifier so it can be Lazy loaded. - DONE
- In `kickstart2/lua/custom/plugins` include a file named `nvim-tree.lua` containing the `setup()` for your plugin.
- In `kickstart2/lua/init.lua` file disable NeoVim's native filesystem navicator `netrw` by add `vim.g.loaded_netrw = 1`
  and `vim.g.loaded_netrwPlugin = 1` to top of the `kickstart2/lua/init.lua` file.

#### Step 5

#### Step 6

#### Step 7

[01]: https://github.com/nvim-lua/kickstart.nvim

[02]:
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:

---

# kickstart-modular.nvim

## Introduction

_This is a fork of [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that moves from a single file to a multi file configuration._

A starting point for Neovim that is:

- Small
- Modular
- Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

- What should I do if I already have a pre-existing neovim configuration?
  - You should back it up and then delete all associated files.
  - This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
- Can I keep my existing configuration in parallel to kickstart?

  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:

  ```bash
  alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
  ```

  When you run Neovim using `nvim-kickstart` alias it will use the alternative
  config directory and the matching local directory
  `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
  distribution that you would like to try out.

- What if I want to "uninstall" this configuration:
  - See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
- Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  - The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
  - [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
    - _NOTE: This is the fork that splits the configuration into smaller parts._
      The original repo with the single `init.lua` file is available here:
  - [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
    - Discussions on this topic can be found here:
  - [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
  - [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

# Debian Install Steps

```bash
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```

### LuaCheck Configuration File

LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
If not found, it will look for it in the parent directory and so on,
going up until it reaches file system root.

```lua
-- LuaCheck `.luacheckrc` file

-- LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
-- If not found, it will look for it in the parent directory and so on,
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

- [LuaCheck Configuration File](https://luacheck.readthedocs.io/en/stable/config.html)
