#!/usr/bin/bash

docker run -it --rm --volumes-from data --name update nccts/nccts-data:latest '\
    pull_site.sh tagged'
