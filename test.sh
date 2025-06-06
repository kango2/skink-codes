#!/bin/bash

# Input file
input_file="/g/data/xl04/jc4878/github/skink-codes/samples.csv"

# Temporary file to store intermediate output
tmpfile=$(mktemp)

# Extract first two columns and sort
awk -F',' '{print $1, $2}' "$input_file" | sort > "$tmpfile"

# Loop through unique sample names (column 1)
for sample in $(cut -d' ' -f1 "$tmpfile" | uniq); do
    # Count how many lanes/entries this sample has
    count=$(grep "^$sample " "$tmpfile" | wc -l)
    if [ "$count" -gt 1 ]; then
        # Build merge command
        merge_cmd="samtools merge $sample"
        # Append each lane name (column 2)
        lanes=$(grep "^$sample " "$tmpfile" | awk '{print $2}')
        for lane in $lanes; do
            merge_cmd+=" $lane"
        done
        # Print the command
        echo "$merge_cmd"
    fi
done

# Cleanup
rm "$tmpfile"

