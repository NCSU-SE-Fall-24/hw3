input_file="titanic.csv"

output_file="filtered_passengers.csv"

passenger_count=0
total_age=0

# awk -F"," '$3 == "2" && $13 == "S" && $7 != "" { $6 = ($6 == "male" ? "M" : ($6 == "female" ? "F" : $6)); total_age += $7; passenger_count++; print $0 } END { if (passenger_count > 0) { print "Total: " total_age "\nPassengers: " passenger_count "\nAverage Age of Filtered Passengers: " total_age / passenger_count } else { print "No passengers found." } }' "$input_file" > "$output_file" && echo "Filtered passengers saved to $output_file"

awk -F"," '$3 == "2" && $13 == "S" && $7 != "" { $6 = ($6 == "male" ? "M" : ($6 == "female" ? "F" : $6)); total_age += $7; passenger_count++ } END { if (passenger_count > 0) { average_age = total_age / passenger_count } }' "$input_file"
