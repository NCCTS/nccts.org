#!/bin/bash

npm install -g http-server
cd nccts.org/site/build
http-server -p 8080 -c-1
