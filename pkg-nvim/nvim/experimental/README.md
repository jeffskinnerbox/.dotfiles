# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.


# LazyVim
Neovim with Lazyvim is pretty good out of the box.

* [NeoVim with LazyVim: The most feature rich editor for programming](https://www.youtube.com/watch?v=lojAgyGnzc0)
* [Intro to Customizing LazyVim](https://www.youtube.com/watch?v=jBzmpArdjlE)
* [LazyVim](https://www.youtube.com/playlist?list=PLXJ0on0Dau77THnZeQLqK1hV6s2udsaAm)
* [lazy.nvim explained](https://www.youtube.com/watch?v=_kPg0VBRxJc)
* [Zero to IDE with LazyVim](https://www.youtube.com/watch?v=N93cTbtLCIM)
* [LazyVim From Scratch To BEAST MODE](https://www.youtube.com/watch?v=evCmP4hH7ZU)
* [Effective NeoVim Setup for Full-Stack Web Development in 2024](https://www.youtube.com/watch?v=V070Zmvx9AM)
* [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM)
* [NeoVim with LazyVim: The most feature rich editor for programming](https://www.youtube.com/watch?v=lojAgyGnzc0&t=15s)
* [Ultimate Neovim Setup 2: Installing LazyVim from Scratch](https://www.youtube.com/watch?v=4Bm_F5j-QuY)

* [Switching To LazyVim](https://medium.com/unixification/switching-to-lazyvim-5d497c089c7b)
* [Create a Neovim IDE with LazyVim](https://www.joshmedeski.com/posts/create-a-neovim-ide-with-lazyvim/)
* [LazyVim - A beautiful neovim config for the lazy](https://www.barbarianmeetscoding.com/notes/neovim-lazyvim/)
* [Say Goodbye to Your IDE: Meet LazyVim](https://catalins.tech/lazyvim/)
* [Ultimate Neovim Setup Guide: lazy.nvim Plugin Manager](https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7)
* [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/)
* [The Omakub Manual: Neovim](https://manual.omakub.org/1/read/13/neovim)
* [Customizing LazyVim (Overrides and New Keymaps/Plugins)](https://levelup.gitconnected.com/customizing-lazyvim-overrides-and-new-keymaps-plugins-528feeb547df)
* [My Neovim configuration in 2024](https://www.youtube.com/watch?v=2Meztidjjlg)
* [Project specific configurations in LazyVim with .lazy.lua](https://typecraft.dev/newsletters/2025-01-08/project-specific-configurations-in-lazyvim-with-lazy-lua)
* [Neovim: Replacing Telescope with FZF-LUA](https://www.youtube.com/watch?v=pJincazaOaw)

* [Integrating Snacks.nvim in your Neovim Configuration](https://www.youtube.com/watch?v=NG7P_fPeuA8)
* [Insane Neovim Plugins that Improve Quality of Life](https://www.youtube.com/watch?v=jz51iQZqfrM)
* [Which is Better Flash.nvim OR Leap.nvim?](https://www.youtube.com/watch?v=NG7P_fPeuA8)
* [This Neovim "Plugin" Replaces 40 Others](https://www.youtube.com/watch?v=qyB-sAvW2lI)
* [blink-cmp: Lightning-Fast Autocompletion Built in Rust | Neovim from Scratch Part 6](https://www.youtube.com/watch?v=GKIxgCcKAq4)

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Assuming your replacing your current LazyVim files within your dotfiles directory (i.e. `~/.dofiles`):

#### Step 1: Make a backup of your current Neovim files

```bash
# make backup of your old lazyvim instance
cd ~/.dotfiles/pkg-nvim/nvim/lua/
mv lazyvim ~/tmp
```

#### Step 2: Remove all traces of the old version of LazyVim

```bash
# remove all old lazyvim files from /share /state and /cache directories
trash ~/.local/share/nvim/lua/lazyvim
trash ~/.local/state/nvim/lua/lazyvim
trash ~/.local/cache/nvim/lua/lazyvim
```

#### Step 3: Clone the LazyVim repository and remove the `.git` folder

```bash
# clone the lazyvim repository
#git clone https://github.com/LazyVim/starter ~/.dotfiles/pkg-nvim/nvim/lua/lazyvim
git clone https://github.com/LazyVim/starter ~/.config/lazyvim

# remove the .git directory
#rm -rf ~/.dotfiles/pkg-nvim/nvim/lua/lazyvim/.git
rm -rf ~/.config/lazyvim/.git ~/.config/lazyvim/.gitignore
```

cd ~/.config
ln -s /home/jeff/.dotfiles/pkg-nvim/nvim/lua/lazyvim ~/.config/lazyvim

#### Step 4: Make sure the following scripts are in `~/.dotfiles/pkg-bash/bash_aliases`

```bash
# use `vim-lv` to execute the lazyvim version of neovim
function alacritty-terminal-with-nvim-lazyvim {
    ( alacritty \
            --title "NeoVim using vi-lv (lazyvim)" \
            --option 'font.size=9.0' \
            --option 'window.dimensions.columns=200' \
            --option 'window.dimensions.lines=58' \
            --command nvim "$@" & )
}

#alias vi-lv="NVIM_APPNAME=nvim/lua/lazyvim alacritty-terminal-with-nvim-lazyvim"
alias vi-lv="NVIM_APPNAME=lazyvim alacritty-terminal-with-nvim-lazyvim"
```

#### Step 5: Execute LazyVim for the first time

```bash
# execute lazyvim for the first time:
vim-lv
```

```bash
# remove lazyvim's old operational files
trash ~/.local/share/nvim-lazyvim ~/.local/state/nvim-lazyvim ~/.local/cache/nvim-lazyvim

# create a test site for stow operation
mkdir -p $HOME/tmp/.config/nvim-lazyvim

# do a test run for stow visually inspect for any errors
stow --dir=$HOME/.dotfiles/pkg-nvim/nvim --target=$HOME/tmp/.config/nvim-lazyvim --stow lazyvim

# do the stow for real this time
trash ~/.local/share/nvim-lazyvim ~/.local/state/nvim-lazyvim ~/.local/cache/nvim-lazyvim
mkdir -p $HOME/.config/nvim-lazyvim
stow --dir=$HOME/.dotfiles/pkg-nvim/nvim --target=$HOME/.config/nvim-lazyvim --stow lazyvim
```

Makes sure the following is in your `$HOME/.dotfiles/pkg-bash/bash_aliases` file
so you can run LazyVim:

```bashzy
# supporting function for lazyvim
function alacritty-terminal-with-nvim-lazyvim {
    ( alacritty \
            --title "NeoVim using vi-lv (lazyvim)" \
            --option 'font.size=9.0' \
            --option 'window.dimensions.columns=200' \
            --option 'window.dimensions.lines=58' \
        --command nvim "$@" & )

# alias for the command line for lazyfile
alias vi-lv="NVIM_APPNAME=nvim-lazyvim alacritty-terminal-with-nvim-lazyvim"
```

#### Step 5: Check LazyVim's Health
Via the commandline, enter `:checkhealth`.
With a fresh install, you should get a clean bill of health. 

