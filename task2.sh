#!/bin/bash
printf "%-30s %-10s %-10s\n" "Name" "Size" "Occurrence"
grep -rl "sample" dataset1 | while read line; do
    count=$(cat $line | tr ' ' '\n' | grep "CSC510" | grep -c "CSC510" | uniq -c | awk '{print $2}')
    if [ $count -ge 3 ]; then
        file=$(echo $line)
        size=$(stat -f%z "$file")
        filtered_file=${file/file_/filtered_}
        # Output the file details
        printf "%-30s %-10d %-10d\n" "$filtered_file" "$size" "$count"
    fi
done | gawk '{
    print $0
}' | gawk 'BEGIN { OFS = "\n" }
{
    data[NR] = $0
    split($0, fields, " ")
    sizes[NR] = fields[2]
    occurrences[NR] = fields[3]
}
END {
    for (i = 1; i <= NR; i++) {
        for (j = i + 1; j <= NR; j++) {
            if (occurrences[i] < occurrences[j] || (occurrences[i] == occurrences[j] && sizes[i] < sizes[j])) {
                # Swap the lines
                temp = data[i]
                data[i] = data[j]
                data[j] = temp
                tempSize = sizes[i]
                sizes[i] = sizes[j]
                sizes[j] = tempSize
                tempOcc = occurrences[i]
                occurrences[i] = occurrences[j]
                occurrences[j] = tempOcc
            }
        }
    }
    for (i = 1; i <= NR; i++) {
        print data[i]
    }
}'
