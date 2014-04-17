#!/usr/bin/env bash

DEFAULT_SESSION="work"

session=$DEFAULT_SESSION
if [ "$#" -gt 0 ]; then
    session=$1
fi

tmux has-session -t $session
if [ $? != 0 ]
then
    tmux -2 new-session -s $session -d
fi
tmux -2 attach -t $session
