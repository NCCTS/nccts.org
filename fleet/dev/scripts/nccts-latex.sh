#!/usr/bin/bash

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    watchman --logfile=/home/sailor/watchman.log watch /home/sailor/nccts.org/site/ ; \
    watchman -- trigger /home/sailor/nccts.org/site/ tex-to-pdf "source/tex/CLCC-Manual.tex" -- \
        /usr/local/texlive/2014/bin/x86_64-linux/pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/ tex-to-xml "source/tex/CLCC-Manual.tex" -- \
        /usr/local/bin/latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/CLCC-Manual.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/ xml-to-html "source/tex/build/CLCC-Manual.xml" -- \
        /usr/local/bin/latexmlpost --destination=/home/sailor/nccts.org/site/source/tex/build/index.html \
                    --format=html5 /home/sailor/nccts.org/site/source/tex/build/CLCC-Manual.xml ; \
    bash'
