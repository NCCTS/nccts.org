#!/bin/bash

task=$1
part_name=$2

source_tex="/home/sailor/nccts.org/site/source/tex"

if [ "$task" = "pdf" ]; then
    cd $source_tex
    pdflatex \
        -output-directory "$source_tex/build/clcc" \
        "$source_tex/clcc-$part_name.tex"
    pdflatex \
        -output-directory "$source_tex/build/clcc" \
        "$source_tex/clcc-$part_name.tex"
elif [ "$task" = "xml" ]; then
    latexml \
        --output="$source_tex/build/clcc/clcc-$part_name.xml" \
        "$source_tex/clcc-$part_name.tex"
elif [ "$task" = "html" ]; then
    latexmlpost \
        --destination="$source_tex/build/clcc/$part_name/index.html" \
        --format=html5 "$source_tex/build/clcc/clcc-$part_name.xml" ; \
else
    echo "no matching task, exiting..."
    exit 1
fi
