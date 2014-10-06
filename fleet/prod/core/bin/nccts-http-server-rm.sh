#!/usr//bin/bash

_di=$(docker inspect http-server 2>/dev/null)
if [ "$?" -eq "0" ]; then
    docker rm http-server
fi
