#!/usr/bin/bash

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    source /home/sailor/.bashrc ; \
    export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH ; \

    export source_tex="/home/sailor/nccts.org/site/source/tex" ; \
    export com_scripts="/home/sailor/nccts.org/fleet/common/scripts" ; \

    mkdir -p $source_tex/build
    mkdir -p $source_tex/build/clcc

    export watch_log="/home/sailor/nccts.org/site/watchman-logs" ; \

    watchman --logfile=$watch_log/latex.log watch $source_tex/ ; \

    watchman -- trigger $source_tex/ man-tex-to-pdf "clcc-manual.tex" -- \
        $com_scripts/tex-build.sh pdf manual ; \
    watchman -- trigger $source_tex/ man-tex-to-xml "clcc-manual.tex" -- \
        $com_scripts/tex-build.sh xml manual ; \
    watchman -- trigger $source_tex/ man-xml-to-html "build/clcc/clcc-manual.xml" -- \
        $com_scripts/tex-build.sh html manual ; \

    watchman -- trigger $source_tex/ com-tex-to-pdf "clcc-companion.tex" -- \
        $com_scripts/tex-build.sh pdf companion ; \
    watchman -- trigger $source_tex/ com-tex-to-xml "clcc-companion.tex" -- \
        $com_scripts/tex-build.sh xml companion ; \
    watchman -- trigger $source_tex/ com-xml-to-html "build/clcc/clcc-companion.xml" -- \
        $com_scripts/tex-build.sh html companion ; \

    watchman watch $source_tex/build/ ; \

    watchman -- trigger $source_tex/build/ rsync-latex \
        "*" -- $com_scripts/rsync-latex.sh ; \

    sleep 5 ; \
    touch $source_tex/clcc-manual.tex ; \
    touch $source_tex/clcc-companion.tex ; \

    bash'
