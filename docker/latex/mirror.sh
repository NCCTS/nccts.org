#!/bin/bash

script=$(readlink -f $0)
script_path=$(dirname "$script")

cd $script_path/support
mkdir texlive-mirror
cd texlive-mirror
# Can substitute with preferred CTAN mirror - ftp://
wget --mirror --no-parent ftp://bay.uchicago.edu/tex-archive/systems/texlive/tlnet/ ./
mv bay.uchicago.edu/tex-archive/systems/texlive/tlnet/* ./
rm -rf bay.uchicago.edu
