#! /bin/bash

USD(){
	USD=`echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
}
dirf(){
	dir=`echo $1 | sed 's/ /\\ /g'`
}
comdates(){
	if [ $1 -gt $(date +%Y) ]
	then
		exp=Active
	elif  [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m) ]]
	then
		exp=Active
	else
		exp=Expired
	fi
}
while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4 rec_column5 rec_column6 rec_column7 rec_column8 rec_column9 rec_column10 rec_column11
do
	year="${rec_column8:3:6}"
	mon=$[$((10#${rec_column8:0:2}))]
	comdates $year $mon
	USD $rec_column11
	dirf $rec_column2
	parent_dir=$(echo $rec_column2 | sed 's/ /_/g')
	child_dir=$(echo $rec_column3 | sed 's/ /_/g;t')
	mkdir -p $parent_dir/$child_dir
	cd $parent_dir/$child_dir
	if [ $exp='Active' ]
	then   
	      	echo "Card Type Code : $rec_column1
		Card Type Full Name : $rec_column2
		Issuing Bank : $rec_column3
		Card Number : $rec_column4
		Card Holder's Name : $rec_column5
		CVV/CVV2 : $rec_column6
		Issue Date:$rec_column7
		Expiry Date:$rec_column8
		Billing Date:$rec_column9
		Card PIN:$rec_column10
		Credit Limit:$USD" > $rec_column4.Active
	else	
			echo "Card Type Code:$rec_column1
			Card Type Full Name : $rec_column2
			Issuing Bank :$rec_column3
			Card Number : $rec_column4
			Card Holder's Name :$rec_column5
			CVV/CVV2:$rec_column6
			Issue Date:$rec_column7
			Expiry Date:$rec_column8
			Billing Date:$rec_column9
			Card PIN:$rec_column10
			Credit Limit:$USD " > $rec_column4.Expired
	fi
cd ..
cd ..
done <  <((tail -n +2  "100 CC Records.csv"))



	
