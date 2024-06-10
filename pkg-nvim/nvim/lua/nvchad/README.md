
<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->



------



* [I tried Neovim Distributions so you don't have to](https://www.youtube.com/watch?v=bbHtl0Pxzj8)

* [How to Install Neovim Using the nvchad Framework](https://www.freecodecamp.org/news/install-neovim-with-nvchad/)
* [From Vim Frustration to Neovim Nirvana: How NvChad Revolutionized My Coding Experience!](https://medium.com/@patrickkoss/from-vim-frustration-to-neovim-nirvana-how-nvchad-revolutionized-my-coding-experience-800ea96bd070)
* [Getting Started with Neovim Using NvChad: A Developer’s Guide](https://blog.spoonconsulting.com/getting-started-with-neovim-using-nvchad-a-developers-guide-f97d81e85d60)

* [NvChad](https://nvchad.com/)
* [Neovim for Newbs. FREE NEOVIM COURSE](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn)
* [The perfect Neovim setup for Next.js (it's back)](https://www.youtube.com/watch?v=8um8OYwvz3c)

# Install NvChad
Sources:
* [NvChad: Quickstart](https://nvchad.com/docs/quickstart/install)

## Pre-Requisites
* [NeoVim 0.10](https://github.com/neovim/neovim/releases/tag/v0.10.0) or later
* [Nerd Fonts](https://www.nerdfonts.com/)
* [Ripgrep](https://github.com/BurntSushi/ripgrep) is required for `grep` searching with Telescope
* Make sure to delete any old `nvim` folders from `$HOME/.config/nvim`

**NOTE TO SELF: Replace all this below with a single `.md` document and refereance it here an elsewhere**

Include the following as pre-req:
* NeoVim version 0.10.0 or greater
* Git version 2.40.0 or greater
* Install Nerd Fonts
* Terminal that support true color and [undercurl](https://st.suckless.org/patches/undercurl/)

To fix copy & paste,
install the appropriate clipboard:

```bash
# if your using X Window's X11 protocol
sudo apt install xsel

nstall # if your using X Window's Wayland protocol
sudo apt install wl-clipboard
```

To fix complaints about lack of Python, Node.js, `ripgrep`, etc. support,
do the following installs on the machine hosting your NeoVim:

```bash
# install git (used by the package installers packer.lua and lazy.lua)
sudo apt install git

# install python support of neovim
pip install pynvim

# install node.js, node package manager (npm), and node support of neovim
sudo apt install nodejs
sudo apt install npm
sudo npm install -g neovim

# install ruby and ruby support of neovim
sudo apt install ruby
gem install neovim

# ripgrep (executable is called `rg`) is need by for telescope
sudo apt install ripgrep

# install the alternative to 'find' is need by for telescope
sudo apt install fd-find

# install go language support (needed by mason)
sudo apt install golang
```

```bash
# use the following to cleanout old nvim files
trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share
```

## Install the NvChad Framework
```bash
# make your target directory and clone nvchad configuration files
mkdir $HOME/.dotfiles/pkg-nvim/nvim/lua/nvchad/
git clone https://github.com/NvChad/starter $HOME/.dotfiles/pkg-nvim/nvim/lua/nvchad/
#git clone https://github.com/NvChad/starter ~/tmp/nvchad-test

# update the `init.lua` file to point to nvchad
vi $HOME/.dotfiles/pkg-nvim/nvim/init.lua

# delete the `.git` folder from nvchad's `nvim` folder
rm $HOME/.dotfiles/pkg-nvim/nvim/lua/nvchad/.git
```

Now execute `nvim`, and run within NeoVim `:MasonInstallAll` command
after `lazy.nvim` plugin finishes downloading plugins.

## Update NvCad Plugins
To update all the plugins within NVChad, do the following:
run within NeoVim `:Lazy sync` command.

## Uninstall NvChad Framework
```bash
# use the following to cleanout old nvchad files
trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share

# delete the nvchad folder
rm -r -f $HOME/.dotfiles/pkg-nvim/nvim/lua/nvchad
```

