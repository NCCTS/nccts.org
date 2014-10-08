#!/usr/bin/bash

repo_dir=$1
repo_url=$2

mkdir -p /home/core/repos
cd /home/core/repos

if [ -d "./$repo_dir" ]; then
    echo "pulling repo..."
    cd ./$repo_dir
    git checkout master
    git pull
    latest_tag=$(git describe --abbrev=0 2>/dev/null)
    if [ -n "$latest_tag" ]; then
        git checkout $latest_tag
    else
        echo "no tags, sticking with HEAD on master..."
    fi
else
    echo "cloning repo..."
    git clone $repo_url ./$repo_dir
    chown -R core:core ./$repo_dir
    cd ./$repo_dir
    latest_tag=$(git describe --abbrev=0 2>/dev/null)
    if [ -n "$latest_tag" ]; then
        git checkout $latest_tag
    else
        echo "no tags, sticking with HEAD on master..."
    fi
fi

chown -R core:core /home/core/repos
