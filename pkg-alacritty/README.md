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


# Alacritty
[Alacritty][01] is a cross-platform, [OpenGL (Open Graphics Library)][02] terminal emulator.
Alacritty claims to be
"__a modern terminal emulator that comes with sensible defaults,
but allows for extensive configuration.
By integrating with other applications, rather than reimplementing their functionality,
it manages to provide a flexible set of features with high performance.
The supported platforms currently consist of BSD, Linux, macOS and Windows.__"
Alacritty supports natively scrollback, 24-bit colors (aka [True Color][03]), copy/paste, clicking on URLs, and custom key bindings.

I moved to Alacritty from Gnome-Terminal.
The move wasn't for latency or throughput (I didn't notice any difference for the work I do)
For me the selling point was platfrom portability accross operating systems and a text configiguration file,
which I can edit, backup, or store in via `git`.
I also liked that it didn't try to do everything, for example, tabs or splits,
which are best left to a window manager or terminal multiplexer.
I can leave that job to Tmux.
Where, if I need tabs & splits, and I learn one tool for that function on all platforms.

Last but not least, my text editor experiance is Unix/Linx (i.e. Ed/Vi/Vim/NeoVim) and
Alacritty's easy integration with NeoVim is critical to me.

# Install on Linux

#### Step X: Install Alacritty
```bash
# install alacritty via snap to get the latest release
sudo snap install alacritty --classic

# create blank configuration file
mkdir -p ~/.config/alacritty && touch ~/.config/alacritty/alacritty.toml
```

The Alacritty terminal emulator can be configured by a hidden [TOML file][04]
in your home directory (`~/.config/alacritty/alacritty.toml` aka `$XDG_CONFIG_HOME/alacritty/alacritty.toml`).
A simple configuration to start with is:

```toml
# automatically reload the configuration file when it changes
live_config_reload = true

# sets environment variables that are passed to the shell when alacritty is launched
[env]
TERM = "xterm-256color"         # we are going to use $TERM elsewhere (e.g. tmux)

[window]
decorations = "buttonless"      # removes the macOS title bar and border, giving it a minimal and distraction-free look
dynamic_padding = false         # spacing between the end of the window and the content
opacity = 0.9                   # takes a value between 0-1 and makes the window semi-transparent

[window.padding]
x = 25                          # spacing between the end of the window and the content
y = 20                          # spacing between the end of the window and the content

[font]
size = 20.0
```

The above configuration file will give you the default font.
To choose your font, find out what you have loaded in your environment:

```bash
# to list your installed font styles
fc-list : family style
```

Next you must tell Alacritty specifically the font you want and color palette.
In my case, I want to load the `catppuccin-mocha` color palette
(See the GitHub repository [`alacritty/alacritty-theme`][05] for a list of available color schemes.):

```bash
# install catppuccin-mocha color palette
curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
```

An I'll use one of the Nerd Fonts allreasdy loaded and identify it on the the Alacritty configuration file:

```toml
  .
  .
  .
# color palette, see github catppuccin/alacritty - https://github.com/catppuccin/alacritty
import = [ "~/.config/alacritty/catppuccin-mocha.toml" ]

[font]
size = 9.0

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Heavy"

[font.bold_italic]
family = "JetBrainsMono Nerd Font"
style = "Heavy Italic"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Medium Italic"

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Medium"
  .
  .
  .
```

Sources:
* [Switching To The Alacritty Terminal Emulator](https://www.youtube.com/watch?v=PZPMvTvUf1Y)
* [GPU-Accelerated Terminal Emulator ‘Alacritty’ 0.12.0 Released (How to Install)](https://ubuntuhandbook.org/index.php/2023/03/alacritty-0-12-0-released-how-to-install/)
* [Install alacritty on Ubuntu](https://snapcraft.io/install/alacritty/ubuntu)



------



# Install on MacBook


#### Step X: Install a True Color Terminal (Alacritty)

```bash
# install alacritty
brew install --cask alacritty

# create blank configuration file
mkdir -p ~/.config/alacritty && touch ~/.config/alacritty/alacritty.toml
```

The Alacritty terminal emulator can be configured by a hidden TOML file in your home directory
(`~/.config/alacritty/alacritty.toml`).
A simple configuration to start with is:

```toml
# automatically reload the configuration file when it changes
live_config_reload = true

# sets environment variables that are passed to the shell when alacritty is launched
[env]
TERM = "xterm-256color"

[window]
decorations = "buttonless"      # removes the macOS title bar and border, giving it a minimal and distraction-free look
dynamic_padding = false         # spacing between the end of the window and the content
opacity = 0.9                   # takes a value between 0-1 and makes the window semi-transparent

[window.padding]
x = 25                          # spacing between the end of the window and the content
y = 20                          # spacing between the end of the window and the content

[font]
size = 12.0
```

```bash
# install color palette
git clone https://github.com/catppuccin/alacritty.git ~/.config/alacritty/catppuccin
```

```toml
# automatically reload the configuration file when it changes
live_config_reload = true

# sets environment variables that are passed to the shell when alacritty is launched
[env]
TERM = "xterm-256color"

[window]
decorations = "buttonless"      # removes the macOS title bar and border, giving it a minimal and distraction-free look
dynamic_padding = false         # spacing between the end of the window and the content
opacity = 0.9                   # takes a value between 0-1 and makes the window semi-transparent

[window.padding]
x = 25                          # spacing between the end of the window and the content
y = 20                          # spacing between the end of the window and the content

[font]
size = 20.0

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Heavy"

[font.bold_italic]
family = "JetBrainsMono Nerd Font"
style = "Heavy Italic"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Medium Italic"

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Medium"

# color palette
import: [~/.config/alacritty/catppuccin/catppuccin-mocha.toml]
```

Sources:
* [How To Make Your Boring macOS Terminal Amazing With Alacritty](https://www.youtube.com/watch?v=uOnL4fEnldA)
* [Set up Alacritty for a fast, minimal, terminal emulator](https://www.joshmedeski.com/posts/setting-up-alacritty-for-a-fast-minimal-terminal-emulator/)
* [GitHub: alacritty/alacritty-theme - Collection of Alacritty color schemes](https://github.com/alacritty/alacritty-theme)



[01]:https://alacritty.org/
[02]:https://en.wikipedia.org/wiki/OpenGL
[03]:https://gist.github.com/kurahaupo/6ce0eaefe5e730841f03cb82b061daa2
[04]:https://toml.io/en/
[05]:https://github.com/alacritty/alacritty-theme
[06]:
[07]:
[08]:
[09]:
[10]:

