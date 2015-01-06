#!/bin/bash

cd nccts.org

lein run

/home/sailor/nccts.org/fig/build/prod/scripts/rsync-generator.sh
