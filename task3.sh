input_file="titanic.csv"

output_file="filtered_passengers.csv"

passenger_count=0
total_age=0


awk -F"," '{
    
    if ($3 == "2" && $13 == "S") {

        
        if ($7 == "") {
            next;
        }
        
        
        # if ($6 == "male") $6 = "M";
        # if ($6 == "female") $6 = "F";
        
        age = ($7 + 0);
        
        total_age += age;
        passenger_count++;
        
        print $0
    }
} END {
    
    sed "s/male/M/g" input_file

    
    if (passenger_count > 0) {
        average_age = total_age / passenger_count;
        print "Average Age of Filtered Passengers: " average_age;
    } else {
        print "No passengers found.";
    }

}' "$input_file" > "$output_file"


echo "Filtered passengers saved to $output_file"
