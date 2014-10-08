#!/usr/bin/bash

docker run -it --rm --volumes-from data -p 7888:7888 --name generator nccts/clojure:latest '\
    mkdir -p /home/sailor/nccts.org/site/source/clojure/build ; \

    watchman watch /home/sailor/nccts.org/site/source/clojure/build/ ; \

    watchman -- trigger /home/sailor/nccts.org/site/source/clojure/build/ rsync-generator \
        "*" -- /home/sailor/nccts.org/fleet/dev/scripts/rsync-generator.sh ; \

    cd /home/sailor/nccts.org ; \
    /home/sailor/bin/lein repl :headless :host 0.0.0.0 :port 7888 ; \

    bash'
