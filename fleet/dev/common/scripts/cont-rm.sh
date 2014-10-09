#!/usr//bin/bash

_di=$(docker inspect "$1" 2>/dev/null)
if [ "$?" -eq "0" ]; then
    docker rm "$1"
fi
