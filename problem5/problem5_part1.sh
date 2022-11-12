#! /bin/bash
#function to convert card limit format
usdfunction(){
    #placing , after every three digits then placing $ in front and usd in end of string
    usd=`echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'` 
}

#function to compare dates
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
while IFS="," read -r card_type_code card_type_full_name issuing_bank card_number card_holder cvv issue_date expiry_date billing_date card_pin card_limit
do
	ex_year="${expiry_date:3:6}" #extracting expiry year
	ex_month=$[$((10#${expiry_date:0:2}))] #extracting expiry mounth and changing base to 10 (to remove value too great for base)
	compare_dates $ex_year $ex_month #call for compare dates function with arguemnts expiry year and expiry mounth
    #echo $ex_year $ex_month
    #echo $expiry_check
    usdfunction $card_limit
    #echo $usd
    parent_directory=$(echo $card_type_full_name |  sed 's/ /_/g') 
	#echo $parent_directory
	child_directory=$(echo $issuing_bank | sed 's/ /_/g;t')
	#echo $child_directory
	mkdir -p $parent_directory/$child_directory
	cd  $parent_directory/$child_directory
	if [ $expiry_check = 'active' ] #checking if account is active
	then
echo "Card Type Code : $card_type_code
Card Type Full Name : $card_type_full_name
Issuing Bank : $issuing_bank
Card Number : $card_number
Card Holder's Name : $card_holder
CVV/CVV2 : $cvv
Issue Date : $issue_date
Expiry Date : $expiry_date
Billing Date : $billing_date
Card PIN : $card_pin
Credit Limit : $usd" > $rec_column4.active #saving data in bank account number .active file
	else  #if not active then 
echo "Card Type Code : $card_type_code
Card Type Full Name : $card_type_full_name
Issuing Bank : $issuing_bank
Card Number : $card_number
Card Holder's Name : $card_holder
CVV/CVV2 : $cvv
Issue Date : $issue_date
Expiry Date : $expiry_date
Billing Date : $billing_date
Card PIN : $card_pin
Credit Limit : $usd" > $rec_column4.expired #saving data in bank account number .expired file
	fi		
cd ..
cd ..
done < <((tail -n +2 100\ CC\ Records.csv))