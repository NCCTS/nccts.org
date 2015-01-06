#!/bin/bash

export rsync_static="/home/sailor/nccts.org/fig/build/common/scripts/rsync-static.sh"
export source_static="/home/sailor/nccts.org/site/source/static"

$rsync_static

export watch_log="/home/sailor/nccts.org/site/watchman-logs"

watchman --logfile=$watch_log/static.log watch $source_static/

watchman -- trigger $source_static/ rsync-static \
         "*" -- $rsync_static
