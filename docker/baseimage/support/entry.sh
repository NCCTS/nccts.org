#!/bin/bash

sess_name=$1
shift

if [ -n "$*" ]; then
    tmux_cmd=(tmux new-session -s "$sess_name" "$*")
    su_cmd=(su -c "$(printf "%q " "${tmux_cmd[@]}")" - sailor)
    bash -l -c "$(printf "%q " "${su_cmd[@]}")"
else
    bash -l -c "su -c 'tmux new-session -s $sess_name' - sailor"

    # Alternatively, allow `command exit` in a 'sailor'
    # tmux/shell to drop back to a root shell
    # ------------------------------------------------------------
    # bash -l -c "su -c 'tmux new-session -s $sess_name' - sailor; bash"
fi
