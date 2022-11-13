
echo enter n
read n
s=0
while [ $n -gt 0 ]
do
	r=`expr $n % 10`
	s=`expr $s \* 10 + $r`
	n=`expr $n / 10`
done
echo $s
