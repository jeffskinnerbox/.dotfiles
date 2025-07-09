<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg"
        title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->

---------------

[Zellij][01] is a [terminal multiplexer][02], some what like [Tmux][03] and [WexTerm][04],
aimed at developers & operations people or anyone who loves working in the terminal.
Zellij offers a more user-friendly experience with a built-in,
discoverable UI and features like floating panes and true multiplayer sessions.
While Tmux is a well-established tool, Zellij aims to be more accessible,
especially for beginners, by providing a more intuitive interface and keybindings.

Zellij and Tmux are both terminal multiplexers,
but Zellij offers a more user-friendly experience with a built-in,
discoverable UI and features like floating panes and true multiplayer sessions.
While Tmux is a well-established tool, Zellij aims to be more accessible, especially for beginners,
by providing a more intuitive interface and keybindings.

Key Features of Zellij
* **Pane Management**: It allows you to split your terminal window into multiple panes and tabs, either horizontally or vertically.
* **Session Persistence**: One of the standout features of Zellij is its ability to save your session from accidentally closing the terminal.
* **Customizable Layouts**: It comes with pre-defined layouts that you can use to quickly set up your workspace.
* **Plugin Support**: It supports plugins, which means you can extend its functionality by adding new features.
* **Mouse Support**: Unlike some terminal multiplexers that rely solely on keyboard shortcuts, Zellij also supports mouse interactions.
* **Status Bar**: It includes a status bar at the bottom of the screen that displays useful information, such as the current time, battery status, and the name of the current session.

Sources:
* [What the hell is Zellij?](https://www.youtube.com/watch?v=ZPfQS5FHNYQ)
* [Zellij: A Modern Terminal Multiplexer for Linux](https://www.tecmint.com/zellij-linux-terminal-multiplexer/)
* [Zellij User Guide](https://zellij.dev/documentation/)

---------------

# Installing Zellij
The easiest way to install Zellij is through a package for your OS.
I'm using Ubuntu as my OS, so I'll do the [install via `snap`][06]:

```bash
# install snap version of zellij
sudo snap install zellij --classic

# version of installed zellij
$ zellij --version
zellij 0.42.2

# location of zellij' configuration file
$ ls ~/.config/zellij/
config.kdl  config.kdl.bak
```


---------------


# How to Install Zellij Themes
Zellij uses [KDL][05] as its configuration language.


Here are [some example themes][07] that come built-in with Zellij.
You can freely used them by dropping their name into your `~/.config/zellij/config.kdl` file
or use them as a source of inspiration to create your own theme.

Sources:
* [How to install Zellij themes](https://medium.com/@pachoyan/how-to-install-zellij-themes-4f13f373d118)
* [Catppuccin for Zellij](https://github.com/catppuccin/zellij)


---------------


# How to Install Zellij Configuration
Zellij uses [KDL][05] as its configuration language.

Sources:
* [Zellij User Guide: Configuration](https://zellij.dev/documentation/configuration.html)


---------------


# Session Management

* [Zellij User Guide: Session Resurrection](https://zellij.dev/documentation/session-resurrection.html)


---------------


# Plugins

Sources:
* [Zellij User Guide: Plugin Aliases](https://zellij.dev/documentation/plugin-aliases.html)
* [Zellij User Guide: Example Plugins](https://zellij.dev/documentation/plugin-examples.html)
* [Awesome Zellij](https://github.com/zellij-org/awesome-zellij)


---------------



[01]:https://zellij.dev/
[02]:https://en.wikipedia.org/wiki/Terminal_multiplexer
[03]:https://hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/
[04]:https://wezterm.org/
[05]:https://kdl.dev/
[06]:https://snapcraft.io/install/zellij/ubuntu
[07]:https://github.com/zellij-org/zellij/tree/main/zellij-utils/assets/themes

