# Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
# Version:      1.1.0
#
# DESCRIPTION:
#   In Bash, the order in which startup shell script files (~/.bashrc, ~/.bash_profile,
#   ~/.bash_login, ~/.profile, /etc/profile, /etc/bash.bashrc)
#   are processed depends on whether the shell is an interactive login shell
#   or an interactive non-login shell.
#
#       Interactive Login Shell:
#           When Bash is invoked as an interactive login shell (e.g. when you log into a terminal),
#           it first reads and executes commands from /etc/profile`
#           After that, it looks for the following files in your home directory, in this specific order,
#           and executes commands from the first one it finds:
#
#               ~/.bash_profile
#               ~/.bash_login
#               ~/.profile
#
#       Interactive Non-Login Shell:
#           When Bash is started as an interactive non-login shell (e.g. opening a new terminal window
#           or tab within your existing session), it reads and executes commands from ~/.bashrc.
#
#   It's common practice to place commands that should run for all interactive shells
#   (both login and non-login) in ~/.bashrc. To ensure that these commands are also executed in login shells,
#   many ~/.bash_profile (or the first found of the three) files include a line to source the ~/.bashrc file.
#

# source the users .bashrc if it exists
if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi

. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"
