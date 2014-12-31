#!/bin/bash

export source_tex=/home/sailor/nccts.org/site/source/tex
export common_scripts=/home/sailor/nccts.org/fig/prod/common/scripts

mkdir -p $source_tex/build
mkdir -p $source_tex/build/clcc

$common_scripts/tex-build.sh pdf manual
$common_scripts/tex-build.sh xml manual
$common_scripts/tex-build.sh html manual

$common_scripts/tex-build.sh pdf companion
$common_scripts/tex-build.sh xml companion
$common_scripts/tex-build.sh html companion

$common_scripts/rsync-latex.sh
