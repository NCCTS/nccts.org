#!/usr/bin/bash

docker run -it --rm --volumes-from data --name static nccts/baseimage:latest '\
    source /home/sailor/.bashrc ; \

    /home/sailor/nccts.org/fleet/common/scripts/rsync-static.sh'

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    source /home/sailor/.bashrc ; \
    export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH ; \

    export source_tex="/home/sailor/nccts.org/site/source/tex" ; \
    export com_scripts="/home/sailor/nccts.org/fleet/common/scripts" ; \

    mkdir -p $source_tex/build
    mkdir -p $source_tex/build/clcc

    $com_scripts/tex-build.sh pdf manual ; \
    # cannot run latexml build in mem constrained env < 4GB
    # $com_scripts/tex-build.sh xml manual ; \
    $com_scripts/tex-build.sh html manual ; \

    $com_scripts/tex-build.sh pdf companion ; \
    # cannot run latexml build in mem constrained env < 4GB
    # $com_scripts/tex-build.sh xml companion ; \
    $com_scripts/tex-build.sh html companion ; \

    $com_scripts/rsync-latex.sh'

docker run -it --rm --volumes-from data --name generator nccts/clojure:latest '\
    source /home/sailor/.bashrc ; \

    cd /home/sailor/nccts.org ; \
    lein run ; \

    mkdir -p /home/sailor/nccts.org/site/source/clojure/build ; \

    /home/sailor/nccts.org/fleet/common/scripts/rsync-generator.sh'
