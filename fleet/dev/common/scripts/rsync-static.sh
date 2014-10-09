#!/bin/bash

rsync -r --delete \
    /home/sailor/nccts.org/site/source/static \
    /home/sailor/nccts.org/site/build/
