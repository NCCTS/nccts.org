#!/bin/bash

docker run \
       --name build-data \
       -v /home/sailor/nccts.org:/home/sailor/nccts.org \
       quay.io/nccts/nccts-data

docker run \
       --rm \
       --volumes-from build-data \
       --name static \
       quay.io/nccts/baseimage \
       '/home/sailor/nccts.org/fig/prod/common/scripts/rsync-static.sh'

docker run \
       --rm \
       --volumes-from build-data \
       --name latex \
       quay.io/nccts/latex \
       '/home/sailor/nccts.org/fig/prod/common/scripts/run-tex.sh'

docker run \
       --rm \
       --volumes-from build-data \
       --name generator \
       quay.io/nccts/clojure \
       '/home/sailor/nccts.org/fig/prod/common/scripts/run-clj.sh'

docker rm build-data
