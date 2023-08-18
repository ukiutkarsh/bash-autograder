#!/bin/bash

if [ $# -ne 2 ]; then 
    echo "Usage: bash download.sh <link to directory> <cut-dirs argument>"
    exit 1
else 
    wget -np -nH -q -r -P . -R "index.html*" $1 --cut-dirs=$2
    dir=$(ls -d */)
    mv $dir mock_grading 2>/dev/null
    exit 0
fi

