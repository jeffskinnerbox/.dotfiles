#!/usr/bin/bash

# this will purge ALL instances of neovim plugins & state & cache data from the systems of directory.
# all that will remain will be your configruation data (e.g. lua files that define your configurations)
# in effect, use of this function will force neovim to refresh all its plugins a new
function nvim_purge {
  echo -e "\n\nThis function is trashing:"
  echo "    XDG_STATE_HOME = $XDG_STATE_HOME"
  echo "    XDG_DATA_HOME = $XDG_DATA_HOME"

  trash $XDG_STATE_HOME/nvim $XDG_DATA_HOME/nvim
}

# what are the values of key neovim environmental variables
echo -n "NeoVim's Environment Variables: "
echo "These Environment variables are used if defined, else default values are used."
echo "(For more information, enter on NeoVim commandline ':help NVIM_APPNAME')"
echo "    XDG_CONFIG_HOME = $XDG_CONFIG_HOME"
echo "    XDG_DATA_HOME = $XDG_DATA_HOME"
echo "    XDG_STATE_HOME = $XDG_STATE_HOME"
echo "    XDG_RUNTIME_DIR = $XDG_RUNTIME_DIR"
echo "    XDG_CONFIG_DIRS = $XDG_CONFIG_DIRS"
echo "    XDG_DATA_DIRS = $XDG_DATA_DIRS"
echo "    NVIM_APPNAME = $NVIM_APPNAME"

# this is a full clean-up, forcing a re-install all instances of neovim
# and of all plugins with an empty cache & state directories
nvim_purge

