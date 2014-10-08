#!/usr/bin/bash

docker run -it --rm --volumes-from data -p 7888:7888 --name generator nccts/clojure:latest '\
    cd /home/sailor/nccts.org ; \
    /home/sailor/bin/lein repl :headless :host 0.0.0.0 :port 7888 ; \

    bash'
