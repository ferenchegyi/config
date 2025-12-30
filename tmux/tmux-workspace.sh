#!/bin/bash

SESSION="workspace"

if [ "$1" == "kill" ]; then
    tmux kill-session -t $SESSION 2>/dev/null
fi

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Create new session, but don't attach to it yet (-d)
  tmux new-session -d -s $SESSION -n "NVIM"

  # Window 1: Neovim and two small terminals
  tmux split-window -v -l 1 -t $SESSION:1.1
  tmux split-window -h -t $SESSION:1.2
  tmux send-keys -t $SESSION:1.1 'nvim' C-m

  # Window 2: Terminal
  tmux new-window -t $SESSION:2 -n 'Terminal'
  tmux split-window -h -t $SESSION:2

  # Window 3: Docker
  tmux new-window -t $SESSION:3 -n 'Docker'
  
  # Select the first window and pane before attaching
  tmux select-window -t $SESSION:1
  tmux select-pane -t $SESSION:1.1
fi

# Attach logic: checks if we are already inside tmux
if [ -z "$TMUX" ]; then
    tmux attach-session -t $SESSION
else
    tmux switch-client -t $SESSION
fi
