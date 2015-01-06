#!/bin/bash

export source_tex=/home/sailor/nccts.org/site/source/tex
export build_prod_scripts=/home/sailor/nccts.org/fig/build/prod/scripts

mkdir -p $source_tex/build
mkdir -p $source_tex/build/clcc

$build_prod_scripts/tex-build.sh pdf manual
$build_prod_scripts/tex-build.sh xml manual
$build_prod_scripts/tex-build.sh html manual

$build_prod_scripts/tex-build.sh pdf companion
$build_prod_scripts/tex-build.sh xml companion
$build_prod_scripts/tex-build.sh html companion

/home/sailor/nccts.org/fig/build/common/scripts/rsync-latex.sh
