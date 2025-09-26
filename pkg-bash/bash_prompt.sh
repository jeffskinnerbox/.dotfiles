#
# Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
# Version:      1.1.0
#
# DESCRIPTION:
#   Set color bash prompt according to active virtualenv, git branch,
#   and return status of last command.  Sets the bash prompt according to:
#    * the active virtualenv
#    * the branch/status of the current git repository
#    * the return value of the previous command
#    * the fact you just came from Windows and are used to having newlines in
#      your prompts.
#
# USAGE:
#    1. Save this file as ~/.dotfiles/pkg-bash/bash_prompt.sh
#    2. Add the following line to the end of your ~/.dotfiles/pkg-bash/.bashrc
#       or ~/.dotfiles/pkg-bash/.bash_profile:
#         source ~/.bash/bash_prompt.sh
#
# SOURCE:
#   Based on https://gist.github.com/jabbalaci/6651278
#

# default primary prompt, shown below
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ "

function prompt_command() {
  # ------------------------------------- Prompt for Error Code ---------------------------------------
  # this MUST be the very first operation within the PROMPT_COMMAND so `$?` value isn't over written
  if [ $? -eq 0 ]; then
    ERRPROMPT=" ${BWHITE}\$${NCOLOR} "
  else
    ERRPROMPT=" ${BRED}${ON_BLACK}[$?]\$${NCOLOR} "
  fi

  # ------------------------------ Prompt for Conda Virtual Environment -------------------------------
  # function set_conda_prompt() {
  #   if [[ "$CONDA_DEFAULT_ENV" = "" ]]; then
  #       CONDAPROMPT=""
  #   else
  #       CONDAPROMPT="${BBLUE}"["$CONDA_DEFAULT_ENV"]"${NCOLOR}"
  #   fi
  # }

  # ------------------------------ Prompt for Python Virtual Environment ------------------------------
  # function returns true/false if the directory your in has an active virtual environment
  function in_active_venv_dir() {
    [[ "$PWD/.venv" == "$VIRTUAL_ENV" ]]
  }

  # function returns true/false if there is an active virtual environment somewhere
  function venv_is_active() {
    [[ -n "$VIRTUAL_ENV" ]]
  }

  # function returns true/false if the directory your in has a virtual environment but nothing is active
  function in_venv_dir() {
    [[ -d "$PWD/.venv" ]]
  }

  # function to create the python virtual environment message in PS1 prompt
  function set_venv_prompt() {
    if in_active_venv_dir; then # Case 1: your in a directory with an active python virtual environment
      local VENV_PROJ_NAME="$(echo "$VIRTUAL_ENV" | awk -F "/" '{print $(NF-1)}')"
      VENVPROMPT="${BGREEN} VENV-ACTIVE:${VENV_PROJ_NAME}${NCOLOR}"
    elif venv_is_active; then # Case 2: there is an active python virtual environment but you are NOT in it
      local VENV_PROJ_NAME="$(echo "$VIRTUAL_ENV" | awk -F "/" '{print $(NF-1)}')"
      VENVPROMPT="${BYELLOW} VENV-ACTIVE:${VENV_PROJ_NAME}${NCOLOR}"
    elif in_venv_dir; then # Case 3: the directory you are in is a python virtual environment but it is not active
      local VENV_PROJ_NAME="$(basename $PWD)"
      VENVPROMPT="${BCYAN} VENV-INACTIVE:${VENV_PROJ_NAME}${NCOLOR}"
    else # Case 4: there is no active python virtual environment at all
      VENVPROMPT=""
    fi
  }

  # ------------------------------------- Prompt for Git Directory ------------------------------------

  # function to detect whether the current directory is a git repository.
  function is_git_repository() {
    git branch >/dev/null 2>&1
  }

  # determine the branch/state information for this git repository.
  function create_gitprompt() {
    # capture the output of the "git status" command for processing below
    local git_status="$(git status 2>/dev/null)"

    # Set color based on clean/staged/dirty
    if [[ ${git_status} =~ "working tree clean" ]] || [[ ${git_status} =~ "working directory clean" ]]; then
      state="${BGREEN}"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
      state="${BYELLOW}"
    else
      state="${BRED}"
    fi

    # set arrow icon based on status against remote
    local remote_pattern="# Your branch is (.*) of"
    if [[ ${git_status} =~ ${remote_pattern_pattern} ]]; then
      if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
        remote="↑"
      else
        remote="↓"
      fi
    else
      remote=""
    fi

    local diverge_pattern="# Your branch and (.*) have diverged"
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
      remote="↕"
    fi

    # Get the name of the branch.
    local branch_pattern="^On branch ([^${IFS}]*)"
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
      branch=${BASH_REMATCH[1]}
    fi

    # set the final branch string.
    GITPROMPT=" ${state}(${branch})${remote}${NCOLOR}"
  }

  # create the GITPROMPT variable
  function set_git_prompt() {
    if is_git_repository; then
      create_gitprompt
    else
      GITPROMPT=""
    fi
  }

  # -------------------------------------- Title of the Terminal --------------------------------------

  # function at sets the title on the terminal
  # NOTE: ${PWD##*/} will give you just the current directory
  function set_title() {
    echo -ne "\033]0;${USER}@${HOST} - ${PWD}\007"
  }

  # ---------------------------- Set the PS1 Prompt and the Terminal Title ----------------------------

  # using the above functions, create your new (dynamic) PS1 prompt and title on terminal
  set_venv_prompt
  set_git_prompt
  set_title
  export PS1="${BGREEN}\u@\h: ${BWHITE}\w${NCOLOR}${VENVPROMPT}${GITPROMPT}${ERRPROMPT}"
}

# the contents of PROMPT_COMMAND is executed immediately before PS1 is executed via the command-line
PROMPT_COMMAND=prompt_command
