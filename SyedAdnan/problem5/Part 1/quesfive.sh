#!/bin/bash

createbasedir(){

arr=()
#Displaying Each Line of the CSV file
while read line
do
        echo ${line}
done < record.csv

#Splitting the CSV files based on columns and saving it in the array arr
while IFS=',' read -r r1 r2 r3
do

        if echo ${arr[@]} | grep -q -w "$r2"; then
                continue
        else
                arr+=("$r2")
        fi
done < <(tail -n +2 record.csv)

#Creating Parent Directories

for x in "${arr[@]}"
do
        mkdir "${x}"
done

}

# Creating Subdirectories using the second column
createsubdir(){
		
path=$(pwd)
#Creating Subdirectories
while IFS=',' read -r r1 r2 r3 r4
do
        file="$r3"
       
        base="$r2"
       
        dir="$path/$base/$file"
        if [ -d "$dir" ]
        then
                continue;
        else
                mkdir $path/"$base"/"$file"
        fi
done < <( tail -n +2 record.csv)

}

# Creating files with Card Number inside the corresponding parent and subdirectory
insertvalue(){

path=$(pwd)
dt=$(date +"%Y%M")
while IFS=',' read -r r1
do
        head="$r1"
        break;
done < record.csv


IFS=, read -ra vals <<< $head

len=${#vals[@]}
echo "Length of Array: $len"

while IFS=',' read -r r1
do
        printf "\n"

        dir="$path/tempfile.txt"
        for((i=0;i<$len;i++))
        do
                printf "\n"
                IFS=',' read -ra row <<< $r1
                if echo ${vals[$i]} | grep -q -w "Card Type Full Name"; then
                        base="${row[$i]}"
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
                        mnt=${expdt:0:2}
                        exp=$yr$mnt

                        if [ $exp -gt $dt ]
                        then
                                fileext="active"
                        else
                                fileext="expired"
                        fi
                fi

                if echo ${vals[$i]} | grep -q -w "Credit Limit"; then
                        usd=`echo ${row[$i]} | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
                        row[$i]="$usd"
                fi
                echo "${vals[$i]}:${row[$i]}" >> $dir
        done
	# Displaying variables for ease of understanding output
        echo $base
        echo $subdirec
        echo $filename
        echo $expdt
        echo $fileext

        cat "$dir"
        cp "$dir" $path/"$base"/"$subdirec"/"$filename.$fileext.txt"
        rm "$dir"
done < <( tail -n +2 record.csv)
}

# Calling Functions
createbasedir
createsubdir
insertvalue
