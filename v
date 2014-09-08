#!/bin/bash

VEXT="$1"
shift
export VAGRANT_CWD="./vagrant/$VEXT"

vagrant "$@"
