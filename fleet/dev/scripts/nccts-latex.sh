#!/usr/bin/bash

docker run -it --rm --volumes-from data --name latex nccts/latex:latest '\
    watchman --logfile=/home/sailor/watchman.log watch /home/sailor/nccts.org/site/source/tex/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-pdf "CLCC-Manual.tex" -- \
        /usr/local/texlive/2014/bin/x86_64-linux/pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build/clcc \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-tex-to-xml "CLCC-Manual.tex" -- \
        /usr/local/bin/latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Manual.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ man-xml-to-html "build/clcc/CLCC-Manual.xml" -- \
        /usr/local/bin/latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/clcc/manual/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Manual.xml ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-pdf "CLCC-Companion.tex" -- \
        /usr/local/texlive/2014/bin/x86_64-linux/pdflatex \
            -output-directory /home/sailor/nccts.org/site/source/tex/build/clcc \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-tex-to-xml "CLCC-Companion.tex" -- \
        /usr/local/bin/latexml \
            --output=/home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Companion.xml \
            /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \
    watchman -- trigger /home/sailor/nccts.org/site/source/tex/ com-xml-to-html "build/clcc/CLCC-Companion.xml" -- \
        /usr/local/bin/latexmlpost \
            --destination=/home/sailor/nccts.org/site/source/tex/build/clcc/companion/index.html \
            --format=html5 /home/sailor/nccts.org/site/source/tex/build/clcc/CLCC-Companion.xml ; \

    watchman watch /home/sailor/nccts.org/site/source/tex/build/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/tex/build/ rsync-latex \
        "*" -- /home/sailor/nccts.org/fleet/dev/scripts/rsync-latex.sh ; \

    /bin/sleep 5 ; \
    /usr/bin/touch /home/sailor/nccts.org/site/source/tex/CLCC-Manual.tex ; \
    /usr/bin/touch /home/sailor/nccts.org/site/source/tex/CLCC-Companion.tex ; \

    bash'
