#!/usr/bin/bash

docker run -it --rm --volumes-from data -p 80:8080 --name http-server nccts/node:latest '\
    source /home/sailor/.bashrc ; \
    source /home/sailor/.nvm/nvm.sh ; \

    npm install -g http-server ; \

    cd nccts.org/site/build ; \

    http-server -p 8080 -c-1'
