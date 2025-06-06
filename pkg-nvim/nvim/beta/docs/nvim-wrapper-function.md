<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

Make sure NVIM_APPNAME is set in your .bashrc file
Here I test out how I can pass nvim configuration files to nvim so I can run multiple version simultanbiously
It is critical to specify the location of the configuration you wish to use
otherwise nvim will use a series of defaults
To understand these dewfaults, see `:nvim-config`, `nvim -V1 -v`,  for more detail
I'm using `$HOME/.config/nvim/init.lua` as my entry point for `nvim` to access your configuration files


# Expect Behavior

running nvim without any options means it will use the configuration in

```bash
nvim .
nnvim .dotfiles/LICENSE.md
```


# ------------------------------------------------------------------------------


# head1


## head2


## Terminate a Looping Bash Script

In  Linux, the keyboard interrupt signal is a signal sent to a process when the user presses the CTRL+C key combination. By default, when a process receives the keyboard interrupt signal, it terminates and returns control to the command prompt.

* [Terminate Bash Script Loop via Keyboard Interrupt in Linux](https://www.squash.io/terminate-bash-script-loop-via-keyboard-interrupt-in-linux/)
* [The Shell Scripting Tutorial: Trap](https://www.shellscript.sh/trap.html)


## Preventing Bash Script Output

When running a bash script, particullary when running it in the background,
the script may produce terminal output that you would rather supress.
You may want to suppress it completely (eg `/dev/null`) or you may want to redirect the output to a file/log.
There are several ways to redirect the output of a bash script.

* [Preventing Terminal Print from Bash Scripts in Linux](https://www.squash.io/preventing-terminal-print-from-bash-scripts-in-linux/)
* [How to Suppress Output in Bash](https://linuxsimply.com/bash-scripting-tutorial/input-output/output/suppress-output/)


### head3

I use script to develop and test a wrapper function I'll use to create an IDE version of nvim
Below are the sequence of test scripts I used


# NeoVim Wrapper Function: Tmux + Alacritty + NeoVim

To make my NeoVim user experience as robust as possible and make it consistent across OS platform,
I will make use of [Alacritty][01] and [Tmux][02] integrated with [NeoVim][04].
My objects for this architecture are:

1. NeoVim runs inside a terminal emulator, but there are many terminal emulators with many different features.
I want my approach to steer clear of all the problems this could present.
Alacritty gives me a single fast, configurable, portable, widely supported, and modern terminal.
2. Some terminal emulators, and even NeoVim (i.e. screen splitting) provide some
[terminal multiplexing][03] features.
Tmux provides me in a single application, widely supported, extensible, and configurable terminal multiplexer.
As much as possible, I want terminal multiplexing functionality in one place / one tool.
3. As much as possible, I want the presence of three tools to appear as one.
Some integration hooks, or proven integration approaches, already exist between these tools.
I will use these integrations where I can.
4. When my development journey is completed, I anticipate having a tool that can function as
a text editor, a wiki/note-taking tool, and an IDE.
The user experience will inevitably be some what different but I want commonality as much as possible.
I believe sticking with these tools can help maximize my likelihood of success.


# Tmux + Alacritty + NeoVim

The three major components that make up NeoVim instance are Alacritty, Tmux, and of course NeoVim itself.


#### Step 1: Make Sure Alacritty Works as Expected

The very first thing is to make sure `alacritty` is installed and working properly.

```bash
# check alacritty's configuration files
cat $HOME/.config/alacritty/alacritty.toml
cat $HOME/.config/alacritty/keybindings.toml

# execute alacritty
alacritty --title "Alacritty Test Terminal"
```


#### Step 2: Does Nvim Work Within Alacritty

Now we will test automatically execute `nvim` within the `alacritty` terminal
and the results are as expected.
We'll test nvim's internal default configuration,
then test my default configuration (what I call the 'active' configuration),
and test my 'experimental' configuration.
We'll load two files and a directory and make sure you get no errors.

>NOTE: Nvim's user-specific configuration file is located at `$XDG_CONFIG_HOME/nvim/init.vim`,
>by default `~/.config/nvim/init.vim`.
>Starting from Nvim's version 0.5, it is possible to setup Nvim via Lua,
>using the default `~/.config/nvim/init.lua`.
>The system-wide configuration file is located at `$XDG_CONFIG_DIRS/nvim/sysinit.vim`,
>by default `/etc/xdg/nvim/sysinit.vim`.
>When the system-wide configuration file does not exist, Nvim checks for `/usr/share/nvim/sysinit.vim`,
>which is not intended to be edited by users.

```bash
# change your working directory to something of interest
cd ~/.dotfiles/pkg-nvim/nvim/lua/experimental

# force nvim to use its internal configuration
# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim`
alacritty --title "Alacritty Test Terminal" --command nvim -u "" README.md .luacheckrc

# nvim using my personal default configuration, I call 'active'
# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
alacritty --title "Alacritty Test Terminal" --command nvim README.md .luacheckrc

# nvim using a configuration I'm actively developing, I call 'experimental'
# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
NVIM_APPNAME=nvim/lua/experimental alacritty --title "Alacritty Test Terminal" --command nvim README.md .luacheckrc
```


#### Step 3: Create Larger Terminal Window

Now using only `alacritty`, we'll create a larger terminal window with
with features suitable for IDE version of `nvim`.

```bash
# change your working directory to something of interest
cd ~/.dotfiles/pkg-nvim/nvim/lua/experimental

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
# ERROR: doesn't work
alacritty --title 'NeoVim Test Terminal' \
          --option 'font.size=9.0' \
          --option 'window.dimensions.columns=200' \
          --option 'window.dimensions.lines=58' \
          --command nvim README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
NVIM_APPNAME=nvim/lua/active \
    alacritty --title 'NeoVim Test Terminal' \
              --option 'font.size=9.0' \
              --option 'window.dimensions.columns=200' \
              --option 'window.dimensions.lines=58' \
              --command nvim README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
NVIM_APPNAME=nvim/lua/experimental \
    alacritty --title 'Alacritty Test Terminal' \
              --option 'font.size=9.0' \
              --option 'window.dimensions.columns=200' \
              --option 'window.dimensions.lines=58' \
              --command nvim README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
alacritty --title 'Alacritty Test Terminal' \
          --option 'font.size=9.0' \
          --option 'window.dimensions.columns=20' \
          --option 'window.dimensions.lines=58' \
          --option 'env.NVIM_APPNAME="nvim/lua/experimental"' \
          --command nvim README.md .luacheckrc
```

>NOTE: It appears that once you use `alacritty` options (aka `--option`),
>you loss the ability to pickup the `$HOME/.config/nvim/lua/active`
>and you must explicitly pass it to `alacritty`.
>This appears to be a bug.


#### Step 5: Create Wrapper Function

I want a easy way to move from using the 'active' configuration to the 'experimental' configuration
(in fact, any configuration with `$HOME/.config/nvim/lua`).
I want a single function to perform this, where I just pass the referance to the configuration.

```bash
# create a wrapper function
function wrapper-function() {
    alacritty --title 'Alacritty Test Terminal' \
              --option 'font.size=9.0' \
              --option 'window.dimensions.columns=200' \
              --option 'window.dimensions.lines=58' \
              --command nvim "$@" &
}

# change your working directory to something of interest
cd ~/.dotfiles/pkg-nvim/nvim/lua/experimental

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
# ERROR: doesn't work
wrapper-function README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
NVIM_APPNAME=nvim/lua/active wrapper-function README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
NVIM_APPNAME=nvim/lua/experimental wrapper-function README.md .luacheckrc
```


#### Step 6: Hide the Wrapper Function for Daily Work

In my day-to-day work, to save myself from all this NeoVim configuration detail,
I have created an alias for my `nvim` needs.
I have chose to pay respectful knod to my vi-editor past,
and created this for my `.bashrc` file:

```bash
# create a wrapper function to be placed in my `bashrc` file
function alacritty-terminal-with-nvim() {
    alacritty \
      --title 'NeoVim' \
      --option 'font.size=9.0' \
      --option 'window.dimensions.columns=200' \
      --option 'window.dimensions.lines=58' \
      --command nvim "$@"
}

# create a simple alias for this function when using the 'active' configuration
alias vi="NVIM_APPNAME=nvim/lua/active alacritty-terminal-with-nvim"

# change your working directory to something of interest
cd ~/.dotfiles/pkg-nvim/nvim/lua/experimental

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/active`
vi README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
# ERROR: doesn't work
NVIM_APPNAME=nvim/lua/experimental vi README.md .luacheckrc

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
NVIM_APPNAME=nvim/lua/experimental alacritty-terminal-with-nvim README.md .luacheckrc
```

So this allows me to simiply do `vi <files-to-be-edited>` for my day-to-day `nvim` work,
but I can easily switch to using my `nvim` configuration under development by using
`NVIM_APPNAME=nvim/lua/experimental alacritty-terminal-with-nvim <file-to-be-edited>`.
The latter is a much longer command but it will only be used while adding new `nvim`
configuration features.

If this long string is too much,
I could also choose to creating an alias like this:

```bash
# create a simple alias for this function when using the 'experimental' configuration
alias vi-dev="NVIM_APPNAME=nvim/lua/experimental alacritty-terminal-with-nvim"

# NOTE: within nvim, the command `:echo stdpath('config')` should produces `$HOME/.config/nvim/lua/experimental`
vi-dev README.md .luacheckrc
```

And you can generalize this approach to include any of the `nvim` configurations
in `$HOME/.dotfiles/pkg-nvim/nvim/lua`.
For example, to execute the `kickstart` configuration for `nvim`,
just execute the command `NVIM_APPNAME=nvim/lua/kickstart alacritty-terminal-with-nvim`.

---------------

[01]:https://alacritty.org/
[02]:https://www.redhat.com/sysadmin/introduction-tmux-linux
[03]:https://en.wikipedia.org/wiki/Terminal_multiplexer
[04]:https://neovim.io/
