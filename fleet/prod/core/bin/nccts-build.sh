#!/usr/bin/bash

docker run -it --rm --volumes-from data nccts/baseimage:0.0.9 '\
    cp -R nccts.org/site/source/static/* nccts.org/site/build'
