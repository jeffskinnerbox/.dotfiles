<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------


I want to have a stable configuration of NeoVim that I can depend on and use every day,
but at the same time, have a version that I'm experiment with.
In effect, I want to use the stable version of my NeoVim configuration to
participate in editing and testing of the experimental version.
Two NeoVim instances running concurrently but each have its own unique configuration,
and no conflicts with each other.

The closet I have come to this ideal state is setting up my `init.lua` file
with a single line reference to another Lua file
(in effect another `init.lua` file with the desired configuration).
This had two draw backs:
(1) I had to edit a file (but only one line),
(2) but the biggest problem, I could not run the two configuration version concurrently.
The problem is both NeoVim instances have full access to everything in the `~/.config/nvim` directory,
and they step on each other.

I settled for this approach until I read [this post][01].
This article pointed out existence of NeoVim environment variable, `NVIM_APPNAME`,
that can be used to solve my problem.
To be able to use more than one NeoVim configuration,
you’ll need to make a couple changes to your setup:

1. Instead of installing a new configuration in `~/.config/nvim`, install it in a custom `~/.config` subdirectory
2. Each time you open Neovim, specify which configuration you want by setting the `NVIM_APPNAME` environment variable in your launch command.

NeoVim uses `NVIM_APPNAME` to determine which configuration directory to load.
If you don’t include it (or set it to an invalid value),
NeoVim will use the default configuration in `~/.config/nvim`.
Fire up NeoVim and enter the command `:help NVIM_APPNAME` or see [NeoVim documentation][02] for more information
about the use of this environment variable.

>Note: Throughout the help pages, wherever `$XDG_CONFIG_…/nvim` is mentioned it
>is understood to mean `$XDG_CONFIG_…/$NVIM_APPNAME`.

To run the `editor-basic` configurations, just do the following:

```bash
# using the gnome terminal
NVIM_APPNAME=nvim/lua/editor-basic nvim

# using the alacritty terminal
NVIM_APPNAME=nvim/lua/editor-basic vi
```




[01]:https://michaeluloth.com/neovim-switch-configs/
[02]:https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:

