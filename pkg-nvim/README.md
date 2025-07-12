<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

div align="center">
  <img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg"
    title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

* [lazy.nvim explained](https://www.youtube.com/watch?v=_kPg0VBRxJc)
* [LazyVim From Scratch To BEAST MODE](https://www.youtube.com/watch?v=evCmP4hH7ZU)
* [Intro to Customizing LazyVim](https://www.youtube.com/watch?v=jBzmpArdjlE)
* [Neovim Lazy Lua IDE - my simple but powerful setup (98% upvoted)](https://www.youtube.com/watch?v=VljhZ0e9zGE)



* [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
* [Learn How To Use NeoVim As An IDE - With Better Sound & Speed](https://www.youtube.com/watch?v=Ymr6bU5Uf8I&t=0s)
* [5 Reasons I Use Neovim for Text Editing on Linux](https://www.howtogeek.com/reasons-i-use-neovim-for-text-editing-on-linux/)
* [>_ dotfile](https://dotfyle.com/)

This is the root level directory for my NeoVim configuration.
Using [Stow][01], the directory `$HOME/.dotfiles/pkg-nvim/nvim` [symbolical linked][02] to `$HOME/.config/nvim`
This allow NeoVim (aka `nvim`) to pickup the appropriate configuration files
to create my customized instance of `nvim`.

# Installing NeoVim

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

# clean neovim folders -  - optional but recommended
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# doing a full purge of nvim plugins, requiring a re-install of all plugins
trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo \
      ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share

# doing clean with simple command
function nvim_purge {
    trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo \
          ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share
}

# edit all the nvim files
gnome-terminal --title NeoVim -- nvim -p ~/.dotfiles/pkg-nvim/.

# using the alacritty terminal to edit all the nvim files
function alacritty-terminal-with-nvim {
    ( alacritty --title 'NeoVim' \
                --option 'font.size=9.0' \
                --option 'window.dimensions.columns=200' \
                --option 'window.dimensions.lines=60' \
                --command nvim $* & )
}
alias vi=alacritty-terminal-with-nvim
vi ~/.dotfiles/pkg-nvim/.
```

## Promote `experimental` to `active`

```bash
# remove the contents of the active directory
trash $HOME/.dotfiles/pkg-nvim/nvim/lua/active

# clean out any state or data references to the old version of 'active'
trash $XDG_STATE_HOME/nvim/lua/active $XDG_DATA_HOME/nvim/lua/active

# install the contents of experimental to the active directory
mkdir $HOME/.dotfiles/pkg-nvim/nvim/lua/active
cp -r -a $HOME/.dotfiles/pkg-nvim/nvim/lua/experimental/* $HOME/.dotfiles/pkg-nvim/nvim/lua/active
```

Now within the newly created `active` instance of NeoVim,
you will want to change the notification of plugin updates since `active` is considered stable.
To do this, goto the `$HOME/.dotfiles/pkg-nvim/nvim/lua/active/lua/lazy-loader.lua` files
and make sure the `require("lazy").setup()` function contains the following:

```lua
  checker = {         -- automatically check for plugin updates and notify the user so they can perform commandline ":Lazy update"
    enabled = true,   -- if 'true', automatically check for plugin updates periodically and inform ":Lazy" command
    notify = false,   -- if 'true', notify user of any updates
  },
```

Now you need to install and rebuild the NeoVim `active` instance.
You do that via the following:

```bash
# build the new active configuration by executing it for the first time
NVIM_APPNAME=nvim/lua/active alacritty-terminal-with-nvim .
# - OR -
vi .
```

Once the build step is complete, your good to go.
You can use `active` instance via `vi <files>`
or use `experimental` instance via `vi-dev <files>`,
but make sure to only make changes to the `experimental` version.
You want the `active` version to remain stable with no manual changes or plugin updates.

---------------

## NeoVim Linting & Formatting

### LuaCheck Configuration File

LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
If not found, it will look for it in the parent directory and so on,
going up until it reaches file system root.

```lua
-- LuaCheck `.luacheckrc` file

-- LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
-- If not found, it will look for it in the parent directory and so on,
-- going up until it reaches file system root.
-- See https://luacheck.readthedocs.io/en/stable/config.html


-- The `std` option allows setting a custom standard set of globals using a table.
-- This table can have two fields: `globals` and `read_globals`.
-- Both of them should contain a field definition map defining some globals.
-- The simplest way to define globals is to list their names:
std = {
   globals = {  },                 -- these globals can be set and accessed
   read_globals = { "vim", }       -- these globals can only be accessed
}

-- suppress complaints about line length unless greater than 300
max_code_line_length = 300

-- filtering warnings using pattern matching on warning codes, variable names, or both
ignore = {  }
```

* [LuaCheck Configuration File](https://luacheck.readthedocs.io/en/stable/config.html)

### Markdownlint Configuration File

**THIS NEEDS TO BE UPDATED TO markdownlint-cli2**

### ESLint Configuration File

```bash
# install eslint globally
sudo npm install -g eslint

# then install the jsonc plugin
sudo npm install -g eslint-plugin-jsonc
```

Make sure to modify your ESLint configuration file
(`.eslintrc.json` or `.eslintrc.js`) to include JSONC support:

```json
{
  "overrides": [
    {
      "files": ["*.json", "*.jsonc"],
      "extends": ["plugin:jsonc/recommended-with-jsonc"]
    }
  ]
}
```

You can run `eslint` on your JSONC file

```bash
# to see which configuration file is being used
eslint --print-config <your-file>.jsonc

eslint --ext .json,.jsonc <your-file>.jsonc
```



[01]:https://dr563105.github.io/blog/manage-dotfiles-with-gnu-stow/
[02]:https://www.freecodecamp.org/news/linux-ln-how-to-create-a-symbolic-link-in-linux-example-bash-command/

