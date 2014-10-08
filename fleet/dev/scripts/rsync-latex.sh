#!/bin/bash

/usr/bin/rsync -r \
    --exclude '*.aux' \
    --exclude '*.log' \
    --exclude '*.xml' \
    --exclude 'companion/' \
    --exclude 'manual/' \
    /home/sailor/nccts.org/site/source/tex/build \
    /home/sailor/nccts.org/site/
