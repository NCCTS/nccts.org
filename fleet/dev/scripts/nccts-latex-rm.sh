#!/usr//bin/bash

_di=$(docker inspect latex 2>/dev/null)
if [ "$?" -eq "0" ]; then
    docker rm latex
fi
