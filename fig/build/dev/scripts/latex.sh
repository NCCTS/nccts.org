#!/bin/bash

export source_tex="/home/sailor/nccts.org/site/source/tex"
export build_com_scripts="/home/sailor/nccts.org/fig/build/common/scripts"

mkdir -p $source_tex/build
mkdir -p $source_tex/build/clcc

export watch_log="/home/sailor/nccts.org/site/watchman-logs"

watchman --logfile=$watch_log/latex.log watch $source_tex/

watchman -- trigger $source_tex/ man-tex-to-pdf "clcc-manual.tex" -- \
         $build_com_scripts/tex-build.sh pdf manual
watchman -- trigger $source_tex/ man-tex-to-xml "clcc-manual.tex" -- \
         $build_com_scripts/tex-build.sh xml manual
watchman -- trigger $source_tex/ man-xml-to-html "build/clcc/clcc-manual.xml" -- \
         $build_com_scripts/tex-build.sh html manual

watchman -- trigger $source_tex/ com-tex-to-pdf "clcc-companion.tex" -- \
         $build_com_scripts/tex-build.sh pdf companion
watchman -- trigger $source_tex/ com-tex-to-xml "clcc-companion.tex" -- \
         $build_com_scripts/tex-build.sh xml companion
watchman -- trigger $source_tex/ com-xml-to-html "build/clcc/clcc-companion.xml" -- \
         $build_com_scripts/tex-build.sh html companion

watchman watch $source_tex/build/

watchman -- trigger $source_tex/build/ rsync-latex \
         "*" -- $build_com_scripts/rsync-latex.sh

sleep 5
touch $source_tex/clcc-manual.tex
touch $source_tex/clcc-companion.tex

while true; do sleep 86400; done
