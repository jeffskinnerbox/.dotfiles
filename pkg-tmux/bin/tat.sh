#!/bin/bash
#
# Attach or create tmux session named the same as current directory.
#
# Breaking Out Sessions
# The tat script has functionality built in to be able to create a detached session,
# avoiding the concern for session nesting, and then attach to it.
# This allows us "break out" a session based on the current pane,
# even cleaning up the pane after creating the new session.
# The following key binding provides this behavior, mapping it to <prefix>C-b for "break":
#
#     bind-key C-b send-keys 'tat && exit' 'C-m'
#
# # Killing Sessions
# By default, killing a session via closing the final process of the session,
# or explicitly running the kill-session command, will disconnect us from tmux.
# The following mapping of <prefix>K will instead kill the current session
# and switch us to another session, keeping us connected to tmux throughout.
#
#     bind-key K run-shell 'tmux switch-client -n \; kill-session -t "$(tmux display-message -p "#S")" || tmux kill-session'
#
# Source
#     https://thoughtbot.com/upcase/videos/tmux-advanced-workflow
#

path_name="$(basename "$PWD" | tr . -)"
session_name=${1-$path_name}

not_in_tmux() {
  [ -z "$TMUX" ]
}

session_exists() {
  tmux has-session -t "=$session_name"
}

create_detached_session() {
  (TMUX='' tmux new-session -Ad -s "$session_name")
}

create_if_needed_and_attach() {
  if not_in_tmux; then
    tmux new-session -As "$session_name"
  else
    if ! session_exists; then
      create_detached_session
    fi
    tmux switch-client -t "$session_name"
  fi
}

create_if_needed_and_attach

