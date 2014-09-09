#!/bin/bash

mkdir -p /docker-build/support/Downloads
cd /docker-build/support/Downloads
git clone https://github.com/ggreer/the_silver_searcher.git
cd /docker-build/support/Downloads/the_silver_searcher
git checkout 0.24.1
./build.sh
make install
