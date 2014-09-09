#!/bin/bash

mkdir -p /docker-build/support/Downloads
cd /docker-build/support/Downloads
git clone https://github.com/facebook/watchman.git
cd /docker-build/support/Downloads/watchman
git checkout v2.9.8
./autogen.sh
./configure
make
make install
