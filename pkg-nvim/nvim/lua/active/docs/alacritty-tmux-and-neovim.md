<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

- [My Development Setup (Neovim, Tmux, Alacritty & Rust-based CLI Tools](https://www.youtube.com/watch?v=stCXFxC4OH0)
- [My Forever Dev Workflow](https://www.youtube.com/watch?v=_YaI2vDbk0o)


# Tmux + Alacritty + NeoVim
The three major components that make up my NeoVim user experiance are Alacritty, Tmux, and of course NeoVim itself.


## NeoVim
I have not one but several instances of NeoVim in my `.dotfiles` directory.
This is because I have a stable version I used daily
and then I have at least one version which is undergoing enhancement & fixes.
I want to run any of these version anytime I see fit without any substantial reconfiguration of my workflow.
Luckily, NeoVim is well prepare to handle my needs via its `APPNAME` environment variable.

While changing your working instance of NeoVim,
it is wise to purge all the cache and tempory files `nvim` creates.
You can do that with the following:

```bash
#!/usr/bin/bash

# this will purge ALL instances of neovim plugins & state & cache data from the systems of directory.
# all that will remain will be your configruation data (e.g. lua files that define your configurations)
# in effect, use of this function will force neovim to refresh all its plugins a new
function nvim_purge {
  echo -e "\n\nThis function is trashing:"
  echo "    XDG_CACHE_HOME = $XDG_CACHE_HOME"
  echo "    XDG_STATE_HOME = $XDG_STATE_HOME"
  echo "    XDG_DATA_HOME = $XDG_DATA_HOME"

  trash $XDG_CACHE_HOME/nvim $XDG_STATE_HOME/nvim $XDG_DATA_HOME/nvim
}

# what are the values of key neovim environmental variables
echo -n "NeoVim's Environment Variables: "
echo "These Environment variables are used if defined, else default values are used."
echo "(For more information, enter on NeoVim commandline ':help NVIM_APPNAME')"
echo "    XDG_CONFIG_HOME = $XDG_CONFIG_HOME"
echo "    XDG_DATA_HOME = $XDG_DATA_HOME"
echo "    XDG_STATE_HOME = $XDG_STATE_HOME"
echo "    XDG_CACHE_HOME = $XDG_CACHE_HOME"
echo "    XDG_RUNTIME_DIR = $XDG_RUNTIME_DIR"
echo "    XDG_CONFIG_DIRS = $XDG_CONFIG_DIRS"
echo "    XDG_DATA_DIRS = $XDG_DATA_DIRS"
echo "    NVIM_APPNAME = $NVIM_APPNAME"

# this is a full clean-up, forcing a re-install all instances of neovim
# and of all plugins with an empty cache & state directories
nvim_purge()
```


## Alacritty

```bash
# this function creates an alacritty terminal appropriately sized for my 'nvim' instance
# the function is writen so that 'nvim' can accept commandline arguments and run in the background
function alacritty-terminal-with-nvim {
    ( alacritty --title 'NeoVim' \
                --option 'font.size=9.0' \
                --option 'window.dimensions.columns=200' \
                --option 'window.dimensions.lines=60' \
                --command nvim $* & )
}

# this alias allows me to us my old friends name (`vi`) and referances the stable neovim executable via the provided path
# you can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME) to maintain multiple configurations
# also see on neovim commandline ':help NVIM_APPNAME'
#alias vi="NVIM_APPNAME=nvim/lua/kickstart2/ alacritty-terminal-with-nvim"
alias vi=alacritty-terminal-with-nvim                # should be equivalent to - alias vi="NVIM_APPNAME=nvim/lua/active/ alacritty-terminal-with-nvim"
```


## Tmux

- [Practical tmux: A How-To Guide Beyond the Basics](https://www.youtube.com/watch?v=RmSvKKmLjGU)

- [I Love TMUX and you should too](https://www.youtube.com/watch?v=-B5VDp50daI)
- [Vim and tmux](https://www.youtube.com/playlist?list=PL-v3vdeWVEsXo87wHeVSP_x1KTX4G1l8Y)
- [How To Use and Configure Tmux Alongside Neovim](https://www.josean.com/posts/tmux-setup)
- [Be a tmux KING with Tmuxifier | My FAVORITE tmux tool](https://www.youtube.com/watch?v=ceRYL271cao)

- [I'm Never Using Tmux The Same Again!](https://www.youtube.com/watch?v=JFipv1_ycqU)

    - [How to setup Neovim from Scratch - Complete Guide (Including TMUX, Lazy and LSP)](https://www.youtube.com/watch?v=ZjMzBd1Dqz8)

- [How To Use and Configure Tmux Alongside Neovim](https://www.josean.com/posts/tmux-setup)
- [Vim and Tmux](https://www.youtube.com/playlist?list=PL-v3vdeWVEsXo87wHeVSP_x1KTX4G1l8Y)
