ans=0
echo "Enter a number: "
read num
while [ $num -gt 0 ]
do
	rem=`expr $num % 10`
	ans=`expr $ans \* 10`
	ans=`expr $ans + $rem`
	num=`expr $num / 10`
done
echo "Reversed Number is: $ans"
