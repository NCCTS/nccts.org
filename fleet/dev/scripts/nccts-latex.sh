#!/usr/bin/bash

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    mkdir -p /home/sailor/nccts.org/site/build/clcc ; \
    mkdir -p /home/sailor/nccts.org/site/build/clcc/manual ; \
    mkdir -p /home/sailor/nccts.org/site/build/clcc/companion ; \

    watchman --logfile=/home/sailor/watchman.log watch /home/sailor/nccts.org/site/source/tex/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-pdf "CLCC-Manual.tex" -- \
        /usr/local/texlive/2014/bin/x86_64-linux/pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-xml "CLCC-Manual.tex" -- \
        /usr/local/bin/latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/CLCC-Manual.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-xml-to-html "build/CLCC-Manual.xml" -- \
        /usr/local/bin/latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/html/manual/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/CLCC-Manual.xml ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-pdf "CLCC-Companion.tex" -- \
        /usr/local/texlive/2014/bin/x86_64-linux/pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-xml "CLCC-Companion.tex" -- \
        /usr/local/bin/latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/CLCC-Companion.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-xml-to-html "build/CLCC-Companion.xml" -- \
        /usr/local/bin/latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/html/companion/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/CLCC-Companion.xml ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ tex-cp-pdf \
        "build/*.pdf" -- \
            /home/sailor/nccts.org/fleet/dev/scripts/latex-cp-pdf.sh ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ tex-cp-man-html \
        "build/html/manual/*" -- \
            /home/sailor/nccts.org/fleet/dev/scripts/latex-cp-html.sh \
                manual ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ tex-cp-com-html \
        "build/html/companion/*" -- \
            /home/sailor/nccts.org/fleet/dev/scripts/latex-cp-html.sh \
                companion ; \

    bash'
