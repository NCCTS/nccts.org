#!/usr/bin/bash

docker run -it --rm --volumes-from data --name static nccts/baseimage:latest '\
    source /home/sailor/.bashrc ; \

    export rsync_static="/home/sailor/nccts.org/fleet/dev/scripts/rsync-static.sh"
    export source_static="/home/sailor/nccts.org/site/source/static"

    $rsync_static ; \

    watchman watch $source_static/ ; \

    watchman -- trigger $source_static/ rsync-static \
        "*" -- $rsync_static ; \

    bash'
