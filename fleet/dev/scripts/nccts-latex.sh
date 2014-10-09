#!/usr/bin/bash

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    source /home/sailor/.bashrc ; \
    export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH ; \

    watchman --logfile=/home/sailor/watchman.log watch /home/sailor/nccts.org/site/source/tex/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-pdf "CLCC-Manual.tex" -- \
        pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build/clcc \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-xml "CLCC-Manual.tex" -- \
        latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Manual.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-xml-to-html "build/clcc/CLCC-Manual.xml" -- \
        latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/clcc/manual/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Manual.xml ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-pdf "CLCC-Companion.tex" -- \
        pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build/clcc \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-xml "CLCC-Companion.tex" -- \
        latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Companion.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-xml-to-html "build/clcc/CLCC-Companion.xml" -- \
        latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/clcc/companion/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Companion.xml ; \

    mkdir -p /home/sailor/nccts.org/site/source/tex/build ; \

    watchman watch /home/sailor/nccts.org/site/source/tex/build/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/build/ rsync-latex \
        "*" -- /home/sailor/nccts.org/fleet/dev/scripts/rsync-latex.sh ; \

    sleep 5 ; \
    touch /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    touch /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \

    bash'
