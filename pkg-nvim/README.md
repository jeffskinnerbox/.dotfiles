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

- [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
- [Learn How To Use NeoVim As An IDE - With Better Sound & Speed](https://www.youtube.com/watch?v=Ymr6bU5Uf8I&t=0s)

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

# clean neovim folders - optional but recommended
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


## NeoVim Linting & Formating


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

- [LuaCheck Configuration File](https://luacheck.readthedocs.io/en/stable/config.html)


### Markdownlint Configuration File

Markdownlint tries to load configuration from `.mdlrc` file in the current directory.
If not found, it will look for it in the parent directory and so on,
going up until it reaches file home directory.

```lua
-- Markdownlint `.mdlrc` file

-- Markdownlint tries to load configuration from `.mdlrc` file in the current directory.
-- If not found, it will look for it in the parent directory and so on,
-- going up until it reaches file home directory. - https://github.com/markdownlint/markdownlint/blob/main/docs/configuration.md


all
rule 'MD013', :line_length => 300
-- for the linter 'markdownlint', exclued (aka disable) these linting rule
-- See https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html
exclude_rule 'MD007' 'MD012' 'MD013' 'MD022' 'MD033' 'MD035' 'MD041' 'MD045'
```

[01]: https://dr563105.github.io/blog/manage-dotfiles-with-gnu-stow/
[02]: https://www.freecodecamp.org/news/linux-ln-how-to-create-a-symbolic-link-in-linux-example-bash-command/
