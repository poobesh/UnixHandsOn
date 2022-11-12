#! /bin/bash
compare_dates(){
	if [ $1 -gt $(date +%Y) ] #checking is expiry year is greater the current year
	then
		expiry_check=active
	elif [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m) ]] #comparing mounths if year is same
	then
		expiry_check=active
	else
		expiry_check=expired
	fi 
}
while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4 rec_column5 rec_column6 rec_column7 rec_column8 rec_column9 rec_column10 rec_column11
do
	ex_year="${rec_column8:3:6}" #extracting expiry year
	ex_month=$[$((10#${rec_column8:0:2}))] #extracting expiry mounth and changing base to 10 (to remove value too great for base)
	compare_dates $ex_year $ex_month #call for compare dates function with arguemnts expiry year and expiry mounth
    echo $ex_year $ex_month
    echo $expiry_check

done < <((tail -n +2 100\ CC\ Records.csv))