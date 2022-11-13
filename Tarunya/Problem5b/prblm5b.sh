touch consolidated.csv
for Fol in */;do
	echo "$Fol";
	cd "$Fol"
	for F2 in */;do
		echo "$F2";
		cd "$F2";
		for F in *;do
			echo "$F"
			cat "$F" >> "../../consolidated.csv"
		done
		cd ..
	done
	cd ..
done
