#!/bin/bash

cd /home/sailor/nccts.org/site/source/tex

subd=$1
shift

for var in "$@"
do
    cp "$var" "/home/sailor/nccts.org/site/build/clcc/$subd/"
done
