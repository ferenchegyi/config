#!/bin/bash

if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
    # Use the actual path to where you saved your script
    bash ~/.config/tmux/tmux-workspace.sh
fi
