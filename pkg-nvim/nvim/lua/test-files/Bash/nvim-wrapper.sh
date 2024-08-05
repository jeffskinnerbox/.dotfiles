#!/usr/bin/bash

# I use script to develop and test a wrapper function I'll use to create an IDE version of nvim
# Below are the sequance of test scripts I used

# Step 1 - make sure alacritty is working properly and supplies some basic functionality you might need
alacritty --title "Alacritty Test Terminal"

# Step 2 - automatically execute nvim within the alacritty terminal, loading two files
alacritty --title "Alacritty Test Terminal" --command nvim README.md .luacheckrc

# Step 3 - using only alacritty, create a large terminal window with features suitable for IDE version of nvim
alacritty --title 'Alacritty Test Terminal' --option 'font.size=9.0' --option 'window.dimensions.columns=200' --option 'window.dimensions.lines=58'

# Step 4 - execute the system version of nvim within the terminal window
alacritty --title 'NeoVim Test Terminal' --option 'font.size=9.0' --option 'window.dimensions.columns=200' --option 'window.dimensions.lines=58' --command nvim README.md .luacheckrc

# Step 5 - execute a specific version of your nvim configuration within the alacritty terminal window
# NOTE: this does not work
alacritty --title 'NeoVim Test Terminal' --option 'font.size=9.0' --option 'window.dimensions.columns=200' --option 'window.dimensions.lines=58' --command NVIM_APPNAME=nvim/lua/experimental nvim README.md .luacheckrc

# Step 6 - execute a specific version of your nvim configuration within the alacritty terminal window
# NOTE: this does not work
function alacritty-terminal-with-nvim-1() {
    alacritty \
      --title 'NeoVim' \
      --option 'font.size=9.0' \
      --option 'window.dimensions.columns=200' \
      --option 'window.dimensions.lines=58' \
      --command nvim "$@"
}
NVIM_APPNAME=nvim/lua/experimental alacritty-terminal-with-nvim-1 README.md .luacheckrc

# Step 7 - execute a specific version of your nvim configuration, in the background, within the alacritty terminal window
function alacritty-terminal-with-nvim-2() {
    NVIM_APPNAME=nvim/lua/experimental \
      alacritty \
        --title 'NeoVim' \
        --option 'font.size=9.0' \
        --option 'window.dimensions.columns=200' \
        --option 'window.dimensions.lines=58' \
        --command nvim "$@"
}
alacritty-terminal-with-nvim-2 README.md .luacheckrc




#function alacritty-terminal-with-nvim {
#    ( alacritty --title 'NeoVim' \
#                --option 'font.size=9.0' \
#                --option 'window.dimensions.columns=200' \
#                --option 'window.dimensions.lines=58' \
#                --command nvim $* & )
#}
