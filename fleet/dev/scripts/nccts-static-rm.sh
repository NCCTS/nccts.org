#!/usr//bin/bash

_di=$(docker inspect static 2>/dev/null)
if [ "$?" -eq "0" ]; then
    docker rm static
fi
