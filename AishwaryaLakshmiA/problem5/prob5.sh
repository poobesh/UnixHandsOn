#!/bin/bash
file='Records.csv'
h=$(head -n 1 Records.csv)
IFS=',' read -r -a hea <<< "$h"
echo "Writing to the files"
while read line || [ -n "$line" ]; do
        IFS=',' read -r -a arr <<< "$line"
        name=${arr[3]}
        ctf=${arr[1]}
        bank=${arr[2]}
        cmonth=$(date +%m)
        cyear=$(date +%Y)
        IFS='/' read -r -a edate<<< ${arr[7]}
        eyear="${edate[1]}"
        emonth="${edate[0]}"
        #echo "$emonth"
        #echo "$cmonth"
        diffy=$(( eyear - cyear ))
        if [ $diffy -gt 0 ]
        then
                ext="active"
        else
                ext="expired"
        fi
        mkdir -p "$ctf"
        cd "$ctf"
        mkdir -p "$bank"
        cd "$bank"
        for (( i=0; i<=9; i++ ));
        do
                echo "${hea[$i]} : ${arr[$i]}" >> "$name"."$ext".txt
        done
        echo -n "Credit Limit : " >> "$name"."$ext".txt
        echo "\$${arr[10]} USD" | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' >> "$name"."$ext".txt
        cd ..
        cd ..
done < Records.csv