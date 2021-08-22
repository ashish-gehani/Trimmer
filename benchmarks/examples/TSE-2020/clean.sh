#!/usr/bin/env bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"
for dir in */; do
    echo "$dir"
    cd "$dir"
    make clean
    cd ..
done
