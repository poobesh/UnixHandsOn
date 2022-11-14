#!/bin/bash

touch 'Records.csv'
file='Records.csv'
echo "Card Type Code,Card Type Full Name,Issuing Bank,Card Number,Card Holder's Name,CVV/CVV2,Issue Date,Expiry Date,Billing Date,Card PIN,Credit Limit" > $file
for folder in "Cards/*/*/*"
do
	line=`cat $folder`
	word=$(cut -d":" -f2 <<< $line)
	echo $word
	echo $word >> $file
done
