#!/usr/bin/bash

docker run -it --rm --volumes-from data --name static nccts/baseimage:latest '\
    source /home/sailor/.bashrc ; \

    /home/sailor/nccts.org/fleet/dev/scripts/rsync-static.sh ; \

    watchman watch /home/sailor/nccts.org/site/source/static/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/static/ rsync-static \
        "*" -- /home/sailor/nccts.org/fleet/dev/scripts/rsync-static.sh ; \

    bash'
