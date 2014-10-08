#!/usr/bin/bash

docker run -it --rm --volumes-from data --name static nccts/baseimage:latest '\
    /home/sailor/nccts.org/fleet/dev/scripts/static-rsync.sh ; \

    watchman watch /home/sailor/nccts.org/site/source/static/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/static/ static-rsync \
        "*" -- /home/sailor/nccts.org/fleet/dev/scripts/static-rsync.sh ; \

    bash'
