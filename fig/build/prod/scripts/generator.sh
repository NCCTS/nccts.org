#!/bin/bash

cd nccts.org

lein run

/home/sailor/nccts.org/fig/build/common/scripts/rsync-generator.sh
