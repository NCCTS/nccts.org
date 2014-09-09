#!/bin/bash

mkdir bin
wget -O bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.4.3/bin/lein
chmod +x bin/lein
bin/lein version
# version 2.4.3 is buggy!
# https://github.com/technomancy/leiningen/issues/1625
bin/lein downgrade 2.4.2
bin/lein version
