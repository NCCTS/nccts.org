#!/usr/bin/bash

_di=$(docker inspect data 2>/dev/null)
if [ "$?" -eq "1" ]; then
    docker run -it -v /home/sailor/nccts.org --name data nccts/nccts-data:latest '\
        clone_site.sh tagged'
fi
