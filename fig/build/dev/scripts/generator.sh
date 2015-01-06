#!/bin/bash

export clojure_build="/home/sailor/nccts.org/site/source/clojure/build"

mkdir -p $clojure_build

export watch_log="/home/sailor/nccts.org/site/watchman-logs"

watchman --logfile=$watch_log/generator.log watch $clojure_build/

watchman -- trigger $clojure_build/ rsync-generator \
         "*" -- /home/sailor/nccts.org/fig/build/common/scripts/rsync-generator.sh

cd /home/sailor/nccts.org
lein repl :headless :host 0.0.0.0 :port 7888
