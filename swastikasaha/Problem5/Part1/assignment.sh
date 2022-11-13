# #!/bin/bash
# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4 rec_column5 rec_column6 rec_column7 rec_column8 rec_column9 rec_column10 rec_column11
# do
# 	echo "Card Type Code: $rec_column1"
# 	echo "Card Type Full Name: $rec_column2"
# 	echo "Issuing Bank: $rec_column3"
# 	echo "Card Number: $rec_column4"
# 	echo "Card Holder's Name: $rec_column5"
#     echo "CVV/CVV2: $rec_column6"
#     echo "Issue Date: $rec_column7"
# 	echo "Expiry Date: $rec_column8"
# 	echo "Billing Date: $rec_column9"
#     echo "Card Pin: $rec_column10"
#     echo "Credit Limit: $rec_column11"
# 	echo ""
# 	current_date= $(date +'%m/%Y')
# 	if [ $current_date -ge $rec_column8 ]
# 	then
# 		cat > $rec_column4.expired
# 	else
# 		cat > $rec_column4.active
# 	fi
	
# done < <(tail -n+2 '100 CC Records.csv')

# ifs = / arr <<<
#! /bin/bash
usdfunction(){
    usd=`echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
}
dirfunction(){
    dir=`echo $1 | sed 's/ /\\ /g'`
}
compare_dates(){
	if [ $1 -gt $(date +%Y) ]
	then
		expiry_check=active
	elif [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m) ]]
	then
		expiry_check=active
	else
		expiry_check=expired
	fi
}
while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4 rec_column5 rec_column6 rec_column7 rec_column8 rec_column9 rec_column10 rec_column11
do
	ex_year="${rec_column8:3:6}"
	ex_month=$[$((10#${rec_column8:0:2}))]
	compare_dates $ex_year $ex_month
	usdfunction $rec_column11
	dirfunction $rec_column2
	parent_directory=$(echo $rec_column2 |  sed 's/ /_/g')
	#echo $parent_directory
	child_directory=$(echo $rec_column3 | sed 's/ /_/g;t')
	#echo $child_directory
	mkdir -p $parent_directory/$child_directory
	cd  $parent_directory/$child_directory
	if [ $expiry_check = 'active' ]
	then
		echo "Card Type Code : $rec_column1
Card Type Full Name : $rec_column2
Issuing Bank : $rec_column3
Card Number : $rec_column4
Card Holder's Name : $rec_column5
CVV/CVV2 : $rec_column6
Issue Date : $rec_column7
Expiry Date : $rec_column8
Billing Date : $rec_column9
Card PIN : $rec_column10
Credit Limit : $usd" > $rec_column4.active
	else
		echo "Card Type Code : $rec_column1
Card Type Full Name : $rec_column2
Issuing Bank : $rec_column3
Card Number : $rec_column4
Card Holder's Name : $rec_column5
CVV/CVV2 : $rec_column6
Issue Date : $rec_column7
Expiry Date : $rec_column8
Billing Date : $rec_column9
Card PIN : $rec_column10
Credit Limit : $usd" > $rec_column4.expired
	fi		
cd ..
cd ..
done < <((tail -n +2 100\ CC\ Records.csv))
