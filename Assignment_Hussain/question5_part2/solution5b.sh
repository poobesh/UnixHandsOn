#!/bin/bash
touch consolidated.csv
for fol_1 in */;
do
	cd $fol_1
	for fol_2 in */;
	do
		
		cd $fol_2
		for file in *;
		do
			val="cat $file"
			cat "$val" >> "../../consolidated.csv"
		done
		cd -
	done
	cd -
done


