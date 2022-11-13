#!/bin/bash
filecsv='100 CC Records.csv'
IFS=","
present_datem=$(date +'%m')
present_datey=$(date +'%Y')
echo $present_datem
echo $present_datey
i=1 n=0
while read code name bank cardNumber Holdername cvv issue expiry billing pin limit;do
	if [ $n -ge $i ];then
		if [ ! -d $name ];then
			mkdir $name
			mkdir $name/$bank
		else
			if [ -d $name/$bank ];then
				echo "$name with $bank directory exists"
			else
				mkdir $name/$bank
			fi
		fi
		
		expirym=${expiry%/*}
		expiryy=${expiry##*/}
		statuss='active'
		echo "year: $expiryy"
		if [[ $expiryy < $present_datey ]];then
			statuss='expired'
		elif [ $expiryy == $present_datey ];then
			if [[ $expirym < $present_datem ]];then
				statuss='expired'
			else
				statuss='active'
			fi
		else
			statuss='active'
		fi
		echo -en "Card Type Code:$code card type\nFull name:$name\n Issuing bank:$bank \nCard number:$cardNumber\n Card Holder's Name:$Holdername\n CVV/CVV2:$cvv \n issue date:$issue\n expiry Date: $expiry\n billing date:$billing \n card pin:$pin \n credit limit:$limit \n" > $name/$bank/$cardNumber.$statuss.txt
	fi
	n=`expr $n + 1`
done <$filecsv


