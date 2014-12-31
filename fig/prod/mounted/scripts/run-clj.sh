#!/bin/bash

# source /home/sailor/.bashrc

cd nccts.org
lein run

# mkdir -p nccts.org/site/source/clojure/build

/home/sailor/nccts.org/fig/prod/mounted/scripts/rsync-generator.sh
