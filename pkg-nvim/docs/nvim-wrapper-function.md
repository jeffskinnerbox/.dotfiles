<!-- vim: ts=2 sts=2 sw=2 et                                                    -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->

<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "---------------", } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

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


### head3
I use script to develop and test a wrapper function I'll use to create an IDE version of nvim
Below are the sequence of test scripts I used


#### Step 1: Make Sure Alacritty Works as Expected
The very first thing is to make sure `alacritty` is installed and working properly.

```bash
# execute alacritty
alacritty --title "Alacritty Test Terminal"

# check alacritty's configuration files
cat ~/.config/alacritty/alacritty.toml
cat ~/.config/alacritty/keybindings.toml
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

