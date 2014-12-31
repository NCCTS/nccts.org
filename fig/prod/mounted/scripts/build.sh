#!/bin/bash

docker run \
       --name build-data \
       -v /home/sailor/nccts.org:/home/sailor/nccts.org \
       quay.io/nccts/nccts-data

docker run \
       --rm \
       --volumes-from build-data \
       --name static \
       quay.io/nccts/baseimage:latest '\
           # source /home/sailor/.bashrc ; \

           nccts.org/fig/prod/mounted/scripts/rsync-static.sh'

docker run \
       --rm \
       --volumes-from build-data \
       --name latex \
       quay.io/nccts/latex:latest '\
           # source /home/sailor/.bashrc ; \
           # export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH ; \

           export source_tex=nccts.org/site/source/tex ; \
           export mounted_scripts=nccts.org/fig/prod/mounted/scripts ; \

           mkdir -p $source_tex/build ; \
           mkdir -p $source_tex/build/clcc ; \

           $mounted_scripts/tex-build.sh pdf manual ; \
           $mounted_scripts/tex-build.sh xml manual ; \
           $mounted_scripts/tex-build.sh html manual ; \

           $mounted_scripts/tex-build.sh pdf companion ; \
           $mounted_scripts/tex-build.sh xml companion ; \
           $mounted_scripts/tex-build.sh html companion ; \

           $mounted_scripts/rsync-latex.sh'

docker run \
       -it --rm \
       --volumes-from build-data \
       --name generator \
       quay.io/nccts/clojure:latest '\
           # source /home/sailor/.bashrc ; \

           cd nccts.org ; \
           lein run ; \

           # mkdir -p nccts.org/site/source/clojure/build ; \

           nccts.org/fig/prod/mounted/scripts/rsync-generator.sh'

docker rm build-data
