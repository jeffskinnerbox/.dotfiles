<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------


* [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
* [Learn How To Use NeoVim As An IDE](https://www.youtube.com/watch?v=H0J1c48NObc)


# NeoVim Messages
To see messages that my have rolled of the screen or writen over, use the following:

* `:messages` historical listing of command messages
* `g<` command can be used to see the last page of previous command output.
Note: If the output has been stopped with "q" at the more prompt, it will only
be displayed up to this point.

# NeoVim Health Check
`:checkhealth`        full health check of NeoVim and its plugins
`:checkhealth foo`    run healthcheck for the foo plugin
`:checkhealth nvim`   run only the standard NeoVim healthcheck







If you are installing NeoVim for the first time,
you can skip this step, but if your reinstalling or rebuilding NeoVim,
this is an important step.
What is done below is to backup your current `~/.config/nvim`,
but equally important, you have to back (or delete)
your `~/.local/share/nvim` and `~/.local/state/nvim`.

Doing this might become necessary after a package upgrade
or some major editing of NeoVim's configuration files.

```bash
# make a backup of your current nvim folder
mv ~/.config/nvim ~/.config/nvim_bak

# clean neovim folders - optional but recommended
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# a full clean-up, requiring a re-install of all plugins
trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo \
      ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share

# edit all files
gnome-terminal --title NeoVim -- nvim -p ~/.dotfiles/pkg-nvim/.
# OR assuming `alias vi="gnome-terminal --title NeoVim -- nvim -p"`
vi ~/.dotfiles/pkg-nvim/.

XDG_DATA_HOME=~/.config/nvim/share XDG_CONFIG_HOME=~/.config/nvim/ nvim -p ~/.config/nvim/init.lua ~/.config/nvim/lua/active/init.lua ~/.config/nvim/lua/active/plugins.lua

# browse neovim logs
```

# ChatGPT Inside Neovim
* [Running chatGPT inside Neovim](https://medium.com/@soares.alisson/running-chatgpt-inside-neovim-2c56205ec4bc)
* [Awesome plugin: ChatGPT with NeoVim](https://dev.to/xxxuutaxxx/awesome-plugin-chatgpt-with-neovim-571d)

