
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
* [Neovim Lazy Lua IDE - my simple but powerful setup for 2024](https://www.youtube.com/watch?v=VljhZ0e9zGE)



# Install LazyVim
Sources:
* [LazyVim: Installation](https://www.lazyvim.org/installation)
* [Zero to IDE with LazyVim](https://www.youtube.com/watch?v=N93cTbtLCIM)

## Pre-Requisites
Same as NvChad.

## Install the LazyVim Framework
```bash
# make your target directory and clone nvchad configuration files
mkdir $HOME/.dotfiles/pkg-nvim/nvim/lua/lazyvim/
git clone https://github.com/LazyVim/starter $HOME/.dotfiles/pkg-nvim/nvim/lua/lazyvim/
#git clone https://github.com/LazyVim/starter ~/tmp/lazyvim-test

# update the `init.lua` file to point to nvchad
vi $HOME/.dotfiles/pkg-nvim/nvim/init.lua

# delete the `.git` folder from nvchad's `nvim` folder
rm $HOME/.dotfiles/pkg-nvim/nvim/lua/lazyvim/.git
```

## Update LazyVim Plugins
## Uninstall LazyVim Framework

