#!/bin/bash

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tar xvzf ./base91-0.6.0.tar.gz
cd base91-0.6.0
make
mv ./base91 ../
cd ..
rm -rf base91-0.6.0
