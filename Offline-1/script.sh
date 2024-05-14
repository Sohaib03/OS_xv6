#!/bin/bash

maxScore="${1:-100}"
maxStudentId="${2:-5}"

echo "student_id,score" > "output.csv"

for (( id=1; id<=$maxStudentId; id++ ))
do
    file="./Submissions/180512$id/180512$id.sh"

    if [ ! -f "$file" ]; then
        echo "File Not Found"
        continue
    fi

    bash $file > "temp.txt"
    # cat "temp.txt"

    mismatch=$(diff -w "temp.txt" "AcceptedOutput.txt" | grep ">\|<" | wc -l)
    score=$(( maxScore - mismatch*5 ))

    found=0

    for (( cid=1; cid<=$maxStudentId; cid++ )) 
    do
        if [[ "$id" == "$cid" ]]; then
            continue
        fi

        checkFile="./Submissions/180512$cid/180512$cid.sh"

        if [ ! -f "$checkFile" ]; then
            continue
        fi

        diffLine=$(diff -Z -B "$file" "$checkFile" | wc -l)

        if  [ "$diffLine" -eq "0" ]; then
            found=1
        fi
    done

    if [[ "$found" == "1" ]]; then
        score=$(( -$score ))
    fi

    echo "180512$id,$score" >> "output.csv"

    rm "temp.txt"
done
