read -p "Enter Number : " num
var=$num
while [ $var -ne 0 ]
do
	rev=$rev$((var%10))
	var=$((var/10))
done
echo " Reversed Number is $rev"
