grep -l "sample" dataset1/* | while read -r file; do
    count=$(grep -o "CSC510" "$file" | wc -l)
    if (( count >= 3 )); then
        size=$(wc -c < "$file")
        echo "$count $size $file"
    fi
done | sort -nr | sort -k1,1nr -k2,2n | awk '{print $3}' | sed 's/file_/filtered_/g'