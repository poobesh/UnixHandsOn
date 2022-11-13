#!/bin/bash

touch '100 CC Records Remade.csv'
file='100 CC Records Remade.csv'
echo "Card Type Code,Card Type Full Name,Issuing Bank,Card Number,Card Holder's Name,CVV/CVV2,Issue Date,Expiry Date,Billing Date,Card PIN,Credit Limit" > $file
for dir in "cardTypes/*/*/*"
do
	value=`cat $dir`
	word=$(cut -d":" -f2 <<< $value)
	echo $word >> $file
done
