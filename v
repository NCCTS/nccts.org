#!/bin/bash

VEXT="$1"
shift
export VAGRANT_VMWARE_CLONE_DIRECTORY="$HOME/Documents/Virtual Machines.localized"
export VAGRANT_CWD="./vagrant/$VEXT"

vagrant "$@"
