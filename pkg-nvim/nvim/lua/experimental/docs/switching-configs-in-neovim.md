<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------


# Switching Configuration in NeoVim
I want to have a stable configuration of NeoVim that I can depend on and use every day,
but at the same time, have a version that I'm experiment with.
In effect, I want to use the stable version of my NeoVim configuration (which I call `active`)
to participate in editing and testing of the experimental version (which I call `experimental`).
Two NeoVim instances running concurrently but each have its own unique configuration,
and no conflicts with each other.

One approach is to this ideal state is setting up my top level `init.lua` file
(it resides in `~/.dotfiles/pkg-nvim/nvim`).
with a single line reference to another Lua file
(in effect another `init.lua` file in sub-directory with the desired configuration).
This had two draw backs:

1. I had to edit a file (but only one line),
2. but the biggest problem, I could not run the two configuration version concurrently.
The problem is both NeoVim instances have full access to everything in the `~/.config/nvim` directory,
and they step on each other.

I settled for this approach until I read [this][01] and [this][03].
These article pointed out existence of NeoVim environment variable, `NVIM_APPNAME`,
that can be used to solve my problem.
To be able to use more than one NeoVim configuration,
you’ll need to make a couple changes to your setup:

1. Instead of installing a new configuration in `~/.config/nvim`,
install it in a custom `~/.config` sub-directory
(for example `~/.config/nvim/lua/active` and `~/.config/nvim/lua/experimental`)
2. Each time you open Neovim, specify which configuration you want by setting
the `NVIM_APPNAME` environment variable in your launch command
(for example, `NVIM_APPNAME=nvim/lua/active` and `NVIM_APPNAME=nvim/lua/experimental`).

NeoVim uses `NVIM_APPNAME` to determine which configuration directory to load.
If you don’t include it (or set it to an invalid value),
NeoVim will use the default configuration in `~/.config/nvim`.

You can fire up NeoVim and enter the command `:help NVIM_APPNAME`
or see [NeoVim documentation][02] for more information
about the use of this environment variable.

> Note: Throughout the help pages, wherever `$XDG_CONFIG_…/nvim` is mentioned it
> is understood to mean `$XDG_CONFIG_…/$NVIM_APPNAME`.

To run the `active` configurations, just do the following:

```bash
# using the gnome terminal
NVIM_APPNAME=nvim/lua/active nvim
# - OR  -
NVIM_APPNAME=nvim/lua/experimental nvim

# using the nvim wrapper function
NVIM_APPNAME=nvim/lua/active alacritty-terminal-with-nvim
# - OR  -
NVIM_APPNAME=nvim/lua/experimental alacritty-terminal-with-nvim
```

>**NOTE:** To learn about the nvim wrapper function (i.e. `alacritty-terminal-with-nvim`),
>see the document `~/.dotfiles/pkg-nvim/nvim/lua/experimental/docs/nvim-wrapper-function.md`.

Sources:

* [Switching Configs in Neovim][01]
* [Neovim Config Switcher][03]
* [APPNAME](https://neovim.io/doc/user/starting.html#_nvim_appname)
* For more information, enter the following on NeoVim's commandline `:help NVIM_APPNAME`


[01]:https://michaeluloth.com/neovim-switch-configs/
[02]:https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME
[03]:https://www.youtube.com/watch?v=LkHjJlSgKZY

