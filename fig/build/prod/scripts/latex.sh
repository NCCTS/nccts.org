#!/bin/bash

export source_tex="/home/sailor/nccts.org/site/source/tex"
export build_com_scripts="/home/sailor/nccts.org/fig/build/common/scripts"

mkdir -p $source_tex/build
mkdir -p $source_tex/build/clcc

$build_com_scripts/tex-build.sh pdf manual
$build_com_scripts/tex-build.sh xml manual
$build_com_scripts/tex-build.sh html manual

$build_com_scripts/tex-build.sh pdf companion
$build_com_scripts/tex-build.sh xml companion
$build_com_scripts/tex-build.sh html companion

$build_com_scripts/rsync-latex.sh
