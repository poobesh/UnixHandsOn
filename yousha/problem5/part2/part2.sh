#!/bin/bash
# touch result.txt
# for card_type_folder in */
# do
	# cd "$card_type_folder"
	# echo "CD1"
	# for issuing_bank in */
	# do
		# cd "$issuing_bank"
		# echo "CD2"
		# #code here
		# for info in *
		# do
		   # echo "$info"
		   # cat "$info" >> "../../result.txt"
		# done
		# cd ..
	# done
	# cd ..
	
# done

touch comma_file.txt
while read line
do
    echo $line | awk -F': ' '{print $2}' >> comma_file.txt
	
done < result.txt



 
	#remove usd and comma
	# if [ `echo $line | grep -c "$" ` -gt 0 ]
	# then
	  # echo "Success"
	# else
	  # echo "Fail";
	# fi
	