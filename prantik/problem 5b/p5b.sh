touch consolidated.csv
for Folder in */; do
    echo "$Folder";
    cd "$Folder"
    for Folder2 in */; do 
        echo "$Folder2";
        cd "$Folder2"
        for File in *; do 
            echo "$File"
            cat "$File" >> "../../consolidated.csv"
        done
        cd ..
    done
    cd ..
done