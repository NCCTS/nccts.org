#!/usr/bin/bash

docker run -it --rm --volumes-from data nccts/baseimage:latest '\
    cp -R nccts.org/site/source/static/* nccts.org/site/build'
