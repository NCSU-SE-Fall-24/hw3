grep -l "sample" dataset1/* | \
xargs -I{} sh -c '
count=$(grep -o "CSC510" "{}" | wc -l);
if [ "$count" -ge 3 ]; then
    size=$(wc -c < "{}");
    echo "$count $size {}";
fi' | \
sort -k1,1nr -k2,2nr |  # Step 2: Sort by occurrences (descending) and size (descending)
gawk '{print $3}' | \
sed 's/file_/filtered_/g'  # Step 3: Substitute "file_" with "filtered_"