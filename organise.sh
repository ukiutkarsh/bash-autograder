#!/bin/bash

mkdir organised
while read line; do 
    mkdir organised/$line
    cd mock_grading
    cd submissions
    result=$(ls | egrep "$line")
    cd ../../
    cd organised/$line
    while IFS='' read -ra ADDR; do
        for i in "${ADDR[@]}"; do
            ln -s "../../mock_grading/submissions/$i" "$i"
        done
    done <<< "$result"
    cd ../../
done < mock_grading/roll_list
