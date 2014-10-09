#!/usr/bin/bash

docker run -it --rm --volumes-from data -p 7888:7888 --name generator nccts/clojure:latest '\
    source /home/sailor/.bashrc ; \

    export clojure_build="/home/sailor/nccts.org/site/source/clojure/build" ; \

    mkdir -p $clojure_build ; \

    watchman watch $clojure_build/ ; \

    watchman -- trigger $clojure_build/ rsync-generator \
        "*" -- /home/sailor/nccts.org/fleet/common/scripts/rsync-generator.sh ; \

    cd /home/sailor/nccts.org ; \
    lein repl :headless :host 0.0.0.0 :port 7888 ; \

    bash'
