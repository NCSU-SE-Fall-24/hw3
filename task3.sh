input_file="titanic.csv"

cat "$input_file" |
    awk -F"," '$3 == "2" && $13 == "S" && $7 != "" {print $0}' |
    sed -e 's/,male,/,M,/g' -e 's/,female,/,F,/g' |
    tee >(awk -F"," '{total_age += $7; count++} END {if (count > 0) print "Average Age: " total_age / count; else print "No passengers found."}')