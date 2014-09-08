#!/bin/bash

cat "/docker-build/support/bashrc_append_$(whoami).txt" >> $HOME/.bashrc
cat /docker-build/support/bashrc_append_common.txt >> $HOME/.bashrc
cp /docker-build/support/tmux.conf $HOME/.tmux.conf
chmod 644 $HOME/.tmux.conf
