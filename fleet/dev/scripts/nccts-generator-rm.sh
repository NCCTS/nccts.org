#!/usr//bin/bash

_di=$(docker inspect generator 2>/dev/null)
if [ "$?" -eq "0" ]; then
    docker rm generator
fi
