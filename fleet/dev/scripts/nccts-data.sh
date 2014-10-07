#!/usr/bin/bash

_di=$(docker inspect data 2>/dev/null)
if [ "$?" -eq "1" ]; then
    docker run -it -v /home/core/repos/nccts.org:/home/sailor/nccts.org --name data nccts/baseimage:latest '\
        /usr/bin/true'
fi
