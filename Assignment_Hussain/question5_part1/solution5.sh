#!/bin/bash
file='100 CC Records.csv'
cur_mon=$(date +"%m")
cur_year=$(date +"%Y")
while IFS=',' read card_type card_name issue_bank card_num name cvv issue_date expiry_date billing_date card_pin cred_lim
do
	if [ -d $card_name ]
	then
		if [ -d $card_name/$issue_bank ]
		then
			echo -e "Already Exist\n"
		else
			mkdir $card_name/$issue_bank
		fi
	else
		mkdir $card_name
		mkdir $card_name/$issue_bank
	fi
	IFS="/"
	read -ra arr <<< "$expiry_date"
	exp_mon="${arr[0]}"
	exp_year="${arr[1]}"
	isActive='idk'

	if [ $exp_year == $cur_year ]
	then
		if [ $exp_mon \> $cur_mon ]
		then
			isActive='active'
		else
			isActive='expired'
		fi
	elif [ $exp_year \> $cur_year ]
	then
		isActive='active'
	elif [ $exp_year \< $cur_year ]
	then
		isActive='expired'
	fi

	file_name="$card_num.$isActive"

	echo -e "Card type code: $card_type\nCard type name : $card_name\nIssuing Bank : $issue_bank\nCard number: $card_num\ncustomer name: $name\ncvv: $cvv\nissue date: $issue_date\nexpiry date: $expiry_date\nbilling date: $billing_date \npin on the carc : $card_pin\ncred limit : $cred_lim" > $card_name/$issue_bank/$file_name
done < <(tail -n +2 "$file")
echo $cur_mon $cur_year
