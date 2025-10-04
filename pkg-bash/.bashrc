# Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
# Version:      1.2.0
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
# I use the environmental variable MID_PATH to gather up all the compoents
# that while be in my PATH and then export it at the end of this script.
#
# NOTE:
# If you mess up  your .bashrc file, such that the shell isn't usable,
# run the following to create a usable shell
# bash --rcfile /etc/bashrc

#---------------------------------- Test for Interactive Shell ----------------------------------
# If not running interactively, don't do anything and just leave
case $- in
*i*) ;;
*) return ;;
  # caused vagrant to crash when provisioning as root
  #      *) echo "WARNING: Non-interactive shell, so .bashrc is not invoked!"; return ;;
esac

#---------------------------------- Test for Operating System -----------------------------------
if [ "$(uname)" == "Darwin" ]; then # your running on Mac OS X platform
  OPSYS="OS X"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then # your running on Linux platform
  OPSYS="Linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then # your running on Windows NT platform
  OPSYS="Win"
fi

#-------------------------------------- Set Shell Options ---------------------------------------
shopt -s checkwinsize # update the values of LINES and COLUMNS
shopt -s cdspell      # minor errors in cd command are corrected
set -o vi             # set commandline editor to vi editing mode

#----------------------------- Setup for Bash Command Line History ------------------------------
# https://hackernoon.com/hide-the-exported-env-variables-from-the-history-it8q36i1
HISTSIZE=500           # max size of the history in memory during your current session
HISTFILESIZE=2000      # max number of commands that are stored in the history file (~/.bash_history by default) which persists across sessions
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history
shopt -s histappend    # append to the history file, don't overwrite it
shopt -s cmdhist       # save multiple-line commands in history

#------------------------------- Initialize Component's of PATH ---------------------------------
HEAD_PATH="$HOME/bin:$HOME/.local/bin:/snap/bin" # my personal tools & applications
MID_PATH="/usr/bin:/usr/sbin:/usr/local/bin"     # user tools provided by ubuntu
TAIL_PATH="/bin:/sbin"                           # system level tools
export PATH="$HEAD_PATH:$MID_PATH:$TAIL_PATH"

#-------------------------- Setup for Python Development Environments ---------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

#------------------------------------ Initialize PYTHONPATH -------------------------------------
# Set PYTHONPATH so it includes user's private bin if it exists
# added python path to standard path to pickup shebang files
if [ -d "${HOME}/.local/bin" ]; then
  export PYTHONPATH="${HOME}/.local/bin"
fi

#------------------------------- XDG Base Directory Specification -------------------------------
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_DATA_HOME="$HOME/.local/share"            # defines the base directory relative to which user-specific data files should be stored
export XDG_CONFIG_HOME="$HOME/.config"               # defines the base directory relative to which user-specific configuration files should be stored
export XDG_STATE_HOME="$HOME/.local/state"           # defines the base directory relative to which user-specific state files should be stored
export XDG_CACHE_HOME="$HOME/.cache"                 # defines the base directory relative to which user-specific non-essential data files should be stored
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/" # defines the preference-ordered set of base directories to search for data files in addition to the $XDG_DATA_HOME base directory
export XDG_CONFIG_DIRS="/etc/xdg"                    # defines the preference-ordered set of base directories to search for configuration files in addition to the $XDG_CONFIG_HOME base directory

#----------------------------- XDG Base User Directory Specification ----------------------------
# https://wiki.archlinux.org/title/XDG_user_directories
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

#--------------------- Path to Go Application Source Code and Executables -----------------------
#export GOPATH=$HOME/src/go_code

# # Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi

# added by nvm install script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#------------------------------------- Define Bash Aliases --------------------------------------
if [ -f $HOME/.dotfiles/pkg-bash/bash_aliases.sh ]; then
  source $HOME/.dotfiles/pkg-bash/bash_aliases.sh
fi

#-------------------------------- Define Terminal and ls Colors ---------------------------------
if [ -f $HOME/.dotfiles/pkg-bash/bash_colors.sh ]; then
  source $HOME/.dotfiles/pkg-bash/bash_colors.sh
fi

if [ -f $HOME/.dircolors ]; then
  eval $(dircolors $HOME/.dircolors)
fi

#-------------------------------- Setup Colorize Scheme for Bash --------------------------------
# Set color scheme for ls, grep, etc
if [ -r $HOME/.dircolors ]; then
  eval "$(dircolors $HOME/.dircolors)"
fi

#--------------------------- Initialize Arduino Makefile Environment ----------------------------
export ARDUINO_DIR=$HOME/src/arduino-Nov-5-2018                      # directory where arduino is installed
export ARDMK_DIR=$HOME/src/arduino-makefile                          # directory where you have copied the makefile
export AVR_TOOLS_DIR=$HOME/src/arduino-Nov-5-2018/hardware/tools/avr # directory where avr tools are installed

#-------------------------------- Initialize Ansible Environment --------------------------------
export ANSIBLE_CONFIG=$HOME/.ansible.cfg
#export ANSIBLE_ROLES_PATH="$HOME/src/ansible-roles"

#----------------------------------- Initialize Dynamic Prompt ----------------------------------
# set the bash command line prompt to color according to active virtualenv,
# git branch and return status of last command.
if [ -f ${HOME}/.dotfiles/pkg-bash/bash_prompt.sh ]; then
  source $HOME/.dotfiles/pkg-bash/bash_prompt.sh
fi

#------------------------------------- Environment Variable -------------------------------------
export TERM="xterm-256color" # full color Xterm
export VISUAL=vim            # set the default visual editor to vim (also i3 default)
export EDITOR="$VISUAL"      # default text editor

export PAGER=less                           # default pager for i3 window manager
export MANPAGER=less                        # in case your linux has less & more but no pg
export OPENSCADPATH=$HOME/cad/openscad_libs # search path for OpenSCAD libraries

#--------------------------------------- Set ROS 2 Dev Env --------------------------------------
# source the environment to support ROS 2 application development
if [[ "$(uname -n)" == "NucBoxM6" && $TERMINAL == "alacritty-ros" ]]; then
  source /opt/ros/jazzy/setup.bash
fi

#---------------------------------------- Set Conda Path ----------------------------------------
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('$HOME/.miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#   eval "$__conda_setup"
# else
#   if [ -f "$HOME/.miniconda3/etc/profile.d/conda.sh" ]; then
#     . "$HOME/.miniconda3/etc/profile.d/conda.sh"
#   else
#     export PATH="$HOME/.miniconda3/bin:$PATH"
#   fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
#
# # use conda (aka miniconda3) for your python environment
# conda activate base

# # Test for conda activate / activate
# echo " "
# echo -n "'/home/jeff/.miniconda3/bin/python3 --version' is:  "
# /home/jeff/.miniconda3/bin/python3 --version
# echo -n "'/usr/bin/python3 --version' is:  "
# /usr/bin/python3 --version
# echo -n "'python3 --version' is:  "
# python3 --version
# echo -n "'\$PATH' is :  "
# echo $PATH | grep miniconda

#------------------------------------------ Eye Candy -------------------------------------------
# system information tool that displays system information in a visually appealing way,
# including the operating system, kernel version, CPU, memory, and more
#fastfetch

#. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"
