#!/bin/bash

# See - https://github.com/jeffskinnerbox/.dotfiles/blob/main/pkg-nvim/docs/setting-up-neovim.md
#
#If you are installing NeoVim for the first time, you can skip this step, but if your reinstalling or rebuilding NeoVim, this is an important step. What is done below is to backup your current $XDG_CONFIG_HOME/nvim, but equally important, you have to backup (or delete) your $XDG_DATA_HOME/nvim, $XDG_CACHE_HOME/nvim, and $XDG_STATE_HOME/nvim.
#
#Doing this might become necessary after a package upgrade or some major editing of NeoVim's configuration files.
#
#
# One of the simplest ways to run a Linux command is by using the os.system function.
# While os.system is easy to use, it’s not recommended for more complex tasks because it is less flexible and does not provide a way to capture command output directly.
# The subprocess module is a more powerful alternative for running system commands in Python. It allows you to spawn new processes, connect to their input/output/error pipes, and obtain their return codes.
#
# Rewrite using:
# Execute shell commands in Python - https://unix.stackexchange.com/questions/238180/execute-shell-commands-in-python
# How to Execute Linux Commands in Python - https://tecadmin.net/how-to-execute-linux-commands-in-python/
# HOW TO RUN LINUX COMMANDS WITH PYTHON ON THE RASPBERRY PI - https://www.circuitbasics.com/run-linux-commands-with-python/


# make a backup of your current nvim configuration folder
cp -Lr "$XDG_CONFIG_HOME/nvim" "$HOME/tmp/nvim_backup"

# clean neovim other folders - optional
cp -Lr $XDG_STATE_HOME/nvim $HOME/tmp/nvim_backup/state
cp -Lr $XDG_DATA_HOME/nvim $HOME/tmp/nvim_backup/share
cp -Lr $XDG_CACHE_HOME/nvim $HOME/tmp/nvim_backup/cache

# a full clean-up, forcing a re-install of all plugins with an empty cache & state
#trash $XDG_CACHE_HOME/nvim $XDG_STATE_HOME/nvim  \
rm -rf $XDG_CACHE_HOME/nvim $XDG_STATE_HOME/nvim  \
      $XDG_DATA_HOME/nvim $XDG_CONFIG_HOME/nvim/undo \
      $XDG_CONFIG_HOME/nvim/site $XDG_CONFIG_HOME/nvim/swap \
      $XDG_CONFIG_HOME/nvim/plugin $XDG_CONFIG_HOME/nvim/share

# edit the 'active' namespace configuration files, if needed
#gnome-terminal --title NeoVim -- nvim ~/.dotfiles \
#        $XDG_CONFIG_HOME/nvim/init.lua $XDG_CONFIG_HOME/nvim/lua/active/init.lua \
#        $XDG_CONFIG_HOME/nvim/lua/active/plugins.lua

# browse neovim logs
