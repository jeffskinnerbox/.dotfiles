# Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
# Version:      1.1.0
#
# DESCRIPTION:
#   When using Bash, to source a file immediately after opening a terminal,
#   you need to add a line to your Bash configuration file that tells it
#   to source the desired file. The most common and appropriate file for
#   this purpose is ~/.bashrc.
#
# NOTE:
# DO NOT add your current directory to the beginning of your path (like this - export PATH=.:$PATH)
# See - https://www.howtogeek.com/current-directory-isnt-in-path-why-not-and-should-you-fix-it/
#
# NOTE:
# If you mess up  your .bashrc file, such that the shell isn't usable,
# run the following to create a usable shell
# bash --rcfile /etc/bashrc

#########################  Test for Interactive Shell #########################
# If not running interactively, don't do anything and just leave
case $- in
*i*) ;;
*) return ;;
  # caused vagrant to crash when provisioning as root
  #      *) echo "WARNING: Non-interactive shell, so .bashrc is not invoked!"; return ;;
esac

#########################  Test for Operating System  #########################
if [ "$(uname)" == "Darwin" ]; then
  # your running on Mac OS X platform
  OPSYS="OS X"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # your running on Linux platform
  OPSYS="Linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  # your running on Windows NT platform
  OPSYS="Win"
fi

###################### XDG Base Directory Specification ########################
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_DATA_HOME="$HOME/.local/share"            # defines the base directory relative to which user-specific data files should be stored
export XDG_CONFIG_HOME="$HOME/.config"               # defines the base directory relative to which user-specific configuration files should be stored
export XDG_STATE_HOME="$HOME/.local/state"           # defines the base directory relative to which user-specific state files should be stored
export XDG_CACHE_HOME="$HOME/.cache"                 # defines the base directory relative to which user-specific non-essential data files should be stored
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/" # defines the preference-ordered set of base directories to search for data files in addition to the $XDG_DATA_HOME base directory
export XDG_CONFIG_DIRS="/etc/xdg"                    # defines the preference-ordered set of base directories to search for configuration files in addition to the $XDG_CONFIG_HOME base directory

################### XDG Base User Directory Specification ######################
# https://wiki.archlinux.org/title/XDG_user_directories
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

################################ Define Aliases ################################
if [ -f $HOME/.dotfiles/pkg-bash/bash_aliases ]; then
  source $HOME/.dotfiles/pkg-bash/bash_aliases
fi

######################## Define Terminal and ls Colors #########################
if [ -f $HOME/.dotfiles/pkg-bash/bash_colors ]; then
  source $HOME/.dotfiles/pkg-bash/bash_colors
fi

if [ -f $HOME/.dircolors ]; then
  eval $(dircolors $HOME/.dircolors)
fi

###################### Setup for Bash History Environment ######################
# https://hackernoon.com/hide-the-exported-env-variables-from-the-history-it8q36i1
export HISTCONTROL=ignorespace

#################### Setup for Arduino Makefile Environment ####################
export ARDUINO_DIR=$HOME/src/arduino-Nov-5-2018                      # directory where arduino is installed
export ARDMK_DIR=$HOME/src/arduino-makefile                          # directory where you have copied the makefile
export AVR_TOOLS_DIR=$HOME/src/arduino-Nov-5-2018/hardware/tools/avr # directory where avr tools are installed

######################## Setup for Ansible Environment #########################
export ANSIBLE_CONFIG=$HOME/.ansible.cfg
#export ANSIBLE_ROLES_PATH="$HOME/src/ansible-roles"

############## Path to Go Application Source Code and Executables ##############
export GOPATH=$HOME/src/go_code
export PATH=$PATH:$GOPATH/bin

################## Setup for Python Development Environments ###################
# you first must do the following install -
#   curl -s https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# you first must do the following install -
#   git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

################### Setup Colorize Scheme and Dynamic Prompt ###################
# Set color scheme for ls, grep, etc
if [ -r $HOME/.dircolors ]; then
  eval "$(dircolors $HOME/.dircolors)"
fi

############################ Setup Dynamic Prompt ##############################
# set the bash command line prompt to color according to active virtualenv,
# git branch and return status of last command.
if [ -f ${HOME}/.dotfiles/pkg-bash/bash_prompt ]; then
  source $HOME/.dotfiles/pkg-bash/bash_prompt
fi

############################ Enable Bash Completion ############################
#if ! shopt -oq posix; then
#    if [ -f /usr/share/bash-completion/bash_completion ]; then
#        source /usr/share/bash-completion/bash_completion
#    elif [ -f /etc/bash_completion ]; then
#        source /etc/bash_completion
#  fi
#fi

############################## Set Shell Options ##############################
shopt -s checkwinsize # update the values of LINES and COLUMNS
shopt -s cdspell      # minor errors in cd command are corrected

############################# Environment Variable #############################
export TERM="xterm-256color" # full color Xterm
export VISUAL=vim            # set the default visual editor to vim (also i3 default)
export EDITOR="$VISUAL"      # default text editor
#export TERMINAL=gnome-terminal                     # default terminal at login time
export PAGER=less                           # default pager for i3 window manager
export MANPAGER=less                        # in case your linux has less & more but no pg
export OPENSCADPATH=$HOME/cad/openscad_libs # search path for OpenSCAD libraries

############################# Command Line Editing #############################
set -o vi # set commandline editor to vi editing mode

############################# Command Line History #############################
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history
shopt -s histappend    # append to the history file, don't overwrite it
shopt -s cmdhist       # save multiple-line commands in history

################################## Set Paths ##################################
# Set PYTHONPATH so it includes user's private bin if it exists
# added python path to standard path to pickup shebang files
if [ -d "${HOME}/.local/bin" ]; then
  export PYTHONPATH="${HOME}/.local/bin"
  export PATH="$PATH:$PYTHONPATH"
fi

# Set SPLUNK_HOME if your have installed splunk
if [ -d "/opt/splunk" ]; then
  export SPLUNK_HOME="/opt/splunk"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# added by nvm install script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

############################### Set Conda Paths ################################
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/.miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/.miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/.miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# use conda (aka miniconda3) for your python environment
conda activate base

############################## Set ROS 2 Dev Env ###############################
# source the environment to support ROS 2 application development
if [[ "$(uname -n)" == "NucBoxM6" && $TERMINAL == "alacritty-ros" ]]; then
  source /opt/ros/jazzy/setup.bash
fi

# system information tool that displays system information in a visually appealing way,
# including the operating system, kernel version, CPU, memory, and more
#fastfetch
