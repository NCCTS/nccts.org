#!/bin/bash

# source /home/sailor/.bashrc
# export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH

export source_tex=/home/sailor/nccts.org/site/source/tex
export mounted_scripts=/home/sailor/nccts.org/fig/prod/mounted/scripts

mkdir -p $source_tex/build
mkdir -p $source_tex/build/clcc

$mounted_scripts/tex-build.sh pdf manual
$mounted_scripts/tex-build.sh xml manual
$mounted_scripts/tex-build.sh html manual

$mounted_scripts/tex-build.sh pdf companion
$mounted_scripts/tex-build.sh xml companion
$mounted_scripts/tex-build.sh html companion

$mounted_scripts/rsync-latex.sh
