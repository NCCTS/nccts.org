#!/bin/bash

rsync -r \
    --exclude '*.aux' \
    --exclude '*.log' \
    --exclude '*.out' \
    --exclude '*.xml' \
    --exclude 'companion/*.cache' \
    --exclude 'manual/*.cache' \
    --exclude 'companion/*.html' \
    --exclude 'manual/*.html' \
    --include 'companion/*.css' \
    --include 'manual/*.css' \
    --include 'companion/*.png' \
    --include 'manual/*.png' \
    /home/sailor/nccts.org/site/source/tex/build \
    /home/sailor/nccts.org/site/
