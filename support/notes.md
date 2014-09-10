docker run -it --name nccts-site -v /home/core/vagrant/site:/home/sailor/site nccts/baseimage:0.0.8 /bin/true

docker attach $(docker run -dit --volumes-from nccts-site -p 80:8080 nccts/node:0.0.8)
  then...
    npm install -g http-server
    cd site/build
    http-server -c-1 -p 8080
    <ctrl-p><ctrl-q>

docker run -it --volumes-from nccts-site nccts/latex:0.0.8
  then...
    watchman --logfile=$HOME/watchman.log watch ~/site/
    watchman -- trigger ~/site/ tex-to-pdf 'tex/CLCC-Manual.tex' -- pdflatex -output-directory ~/site/tex/build ~/site/tex/CLCC-Manual.tex
    watchman -- trigger ~/site/ tex-to-xml 'tex/CLCC-Manual.tex' -- latexml --output=~/site/tex/build/CLCC-Manual.xml ~/site/tex/CLCC-Manual.tex
    watchman -- trigger ~/site/ xml-to-html 'tex/build/CLCC-Manual.xml' -- latexmlpost --destination=~/site/build/clcc/manual/index.html --format=html5 ~/site/tex/build/CLCC-Manual.xml
    watchman -- trigger ~/site/ cp-pdf-to-build 'tex/build/CLCC-Manual.pdf' -- bash -c 'cp ~/site/tex/build/CLCC-Manual.pdf ~/site/build/clcc/manual/'

