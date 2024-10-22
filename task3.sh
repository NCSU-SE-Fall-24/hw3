#!/bin/bash
initial_filter=$(gawk -F, 'NR >= 2 && $3 == 2 && $13 ~ /S/ {print $0}' titanic.csv)
replacing_gender=$(echo "$initial_filter" | sed -e 's/,male,/,M,/' -e 's/,female,/,F,/')
final_output=$(echo "$replacing_gender" |  gawk -F, 'BEGIN {count = 0; sum_age = 0} {if ($7 != "") {count+=1; sum_age+=$7; print $0}} END {if (count > 0) print "Average age: " sum_age/count; else print "No valid data"}')
echo "$final_output"
