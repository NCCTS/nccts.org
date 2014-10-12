#!/bin/bash

# shell commands to get a sorted count of unique words in this document, assuming gnu coreutils:
# ----------------------------------------------------------------------------------------------------------
export tab=$(echo | tr '\n' '\t')
cat $1                                               `# load the tex file from disk`                     \
    | tr ' ' '\n'                                    `# split into lines on single spaces between words` \
    | tr '[:upper:]' '[:lower:]'                     `# make all characters lowercase`                   \
    | sed -e 's|^[[:punct:]]*||; s|[[:punct:]]*$||;' `# remove leading and trailing punctuation`         \
    | sed "s/^[ $tab]*//;s/[ $tab]*$//"              `# trim leading and trailing whitespace`            \
    | sed '/^\s*$/d'                                 `# remove whitespace-only lines`                    \
    | sort                                           `# initial sort`                                    \
    | uniq -c                                        `# remove duplicates from sorted lines`             \
    | sort -r                                        `# reverse sort so highest count is first`          \
    | awk '{print $1"\t\t"$2}'                       `# print count,word tab-separated columns`
