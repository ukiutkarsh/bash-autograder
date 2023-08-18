#!/bin/bash

touch marksheet.csv
touch distribution.txt
while read line; do 
    cd organised/$line
    mkdir student_outputs
    result=$(ls | egrep "cpp")
    g++ -o executable $result 2>/dev/null |:
    cd ../../mock_grading/inputs
    input=$(ls)
    cd ../../organised/$line
    score=0
    while IFS='' read -ra ADDR; do
        for i in "${ADDR[@]}"; do
            timeout 5 ./executable < ../../mock_grading/inputs/$i > $i 2>/dev/null |:
            mv $i student_outputs
            cd student_outputs
            temp="$(basename $i .in).out"
            mv $i $temp
            res=$(diff $temp ../../../mock_grading/outputs/$temp)
            if [ -z "$res" ]; then
            ((score++))
            fi
            cd ../
        done
    done <<< "$input"
    echo "$line,$score" >> ../../marksheet.csv
    cd ../../
done < mock_grading/roll_list
sort -r -n -t , -k 2 marksheet.csv | cut -d ',' -f2 > distribution.txt