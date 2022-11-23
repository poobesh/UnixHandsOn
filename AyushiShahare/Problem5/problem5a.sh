#!/bin/bash

header=()

foo=`awk '(NR==1)' 100\ CC\ Records.csv`
var=""
for (( i=0; i<${#foo}; i++ )); do
  temp=${foo:$i:1}

  if [[ $((i+1)) == ${#foo} ]]
  then
    header+=("$var")
    var=""
  fi

  if [[ "$temp" == "," ]]
  then
    # echo $var
    header+=("$var")
    var=""
    continue
  fi
  var+=$temp
done

file_size=`wc -l 100\ CC\ Records.csv | awk '{ print $1 }'`

for (( i=0; i<$file_size-1; i++ )); do
  index=$((i+2))
  data=`awk '(NR=='$index')' 100\ CC\ Records.csv`
  final_data=""
  k=0
  filename=""
  date_e=""
  var=""
  temp_month=""
  temp_year=""
  l=0
  for (( j=0; j<${#data}; j++ )); do
    temp=${data:$j:1}

    if [[ $((j+1)) == ${#data} ]]
    then
      echo "${header[k]}: \$${var}${temp} USD" | cat >> file
      continue
    fi

    if [[ "$temp" == "," ]]
    then
      if [[ $k == 3 ]]
      then
        filename=$var
      fi

      echo "${header[k]}: ${var}" | cat >> file
      var=""
      k=$((k+1))
      continue
    fi
    if [[ $k == 7 ]]
    then
      if [[ $l < 2 ]]
      then
        temp_month="${temp_month}$temp"
      fi
      if [[ $l > 2 ]]
      then
        temp_year="${temp_year}$temp"
      fi
      if [[ $l == 6 ]]
      then
        date_e="${temp_year}/${temp_month}"
      fi
      l=$((l+1))
    fi
    var+=$temp
    if [[ $k == 10 && $((j+2)) != ${#data} ]] 
    then
      num=$(($(expr ${#data} - $j)-2))

      if [[ `expr $num % 3` == 0 ]]
      then
        var+=","
      fi
    fi
  done
  month=$(date +%m)
  year=$(date +%Y)
  dt="${year}/${month}"

  if [[ "$date_e" > "$dt" ]]
  then
    filename="${filename}.active"
  else
    filename="${filename}.expired"
  fi

  mv file $filename
done