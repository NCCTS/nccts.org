#!/bin/bash

cd /home/sailor/nccts.org/site/source/tex

for var in "$@"
do
    cp "$var" /home/sailor/nccts.org/site/build/clcc/
done
