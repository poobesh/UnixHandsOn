#!/bin/bash

basedir(){

arr=()

while read line
do
        echo ${line}
done < bank.csv


while IFS=',' read -r r1 r2 r3
do

        if echo ${arr[@]} | grep -q -w "$r2"; then
                continue
        else
                arr+=("$r2")
        fi
done < <(tail -n +2 bank.csv)


for x in "${arr[@]}"
do
        mkdir "${x}"
done
}

subdir(){
		
path=$(pwd)
while IFS=',' read -r r1 r2 r3 r4
do
        subd="$r3"
       
        dir="$r2"
       
        loc="$path/$dir/$subd"
        if [ -d "$loc" ]
        then
                continue;
        else
                mkdir $path/"$dir"/"$subd"
        fi
done < <( tail -n +2 bank.csv)

}

insertvalue(){

path=$(pwd)
dt=$(date +"%Y%M")
while IFS=',' read -r r1
do
        head="$r1"
        break;
done < bank.csv


IFS=, read -ra vals <<< $head

lt=${#vals[@]}

while IFS=',' read -r r1
do
        printf "\n"

        dir="$path/testfile.txt"
        for((i=0;i<$lt;i++))
        do
                printf "\n"
                IFS=',' read -ra row <<< $r1
                if echo ${vals[$i]} | grep -q -w "Card Type Full Name"; then
                        basedirec="${row[$i]}"
                fi

                if echo ${vals[$i]} | grep -q -w "Issuing Bank"; then
                        subdirec="${row[$i]}"
                fi

                if echo ${vals[$i]} | grep -q -w "Card Number"; then
                        filename="${row[$i]}"
                fi

                if echo ${vals[$i]} | grep -q -w "Expiry Date"; then
                        expdt="${row[$i]}"
                        yr=${expdt:3:4}
                        m=${expdt:0:2}
                        exp=$yr$m

                        if [ $exp -gt $dt ]
                        then
			         dot="active"
                        else
			         dot="expired"
                        fi
                fi

                if echo ${vals[$i]} | grep -q -w "Credit Limit"; then
                        usd=`echo ${row[$i]} | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
                        row[$i]="$usd"
                fi
                echo "${vals[$i]}:${row[$i]}" >> $dir
        done
	
        echo $basedirec
        echo $subdirec
        echo $filename
        echo $expdt
        echo $dot

        cat "$dir"
        cp "$dir" $path/"$basedirec"/"$subdirec"/"$filename.$dot.txt"
        rm "$dir"
done < <( tail -n +2 bank.csv)
}


basedir
subdir
insertvalue
