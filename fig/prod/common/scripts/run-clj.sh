#!/bin/bash

cd nccts.org

lein run

/home/sailor/nccts.org/fig/prod/common/scripts/rsync-generator.sh
