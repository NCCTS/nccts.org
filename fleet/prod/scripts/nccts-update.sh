#!/usr/bin/bash

docker run -it --rm --volumes-from data nccts/nccts-data:latest '\
    pull_site.sh tagged'
