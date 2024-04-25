#!/bin/bash

# Output file to store results
output_file="directory_info.txt"

# Clear the output file or create it if it doesn't exist
echo "" > "$output_file"

# Iterate through each subdirectory in "customers"
for dir in customers/*; do
  if [ -d "$dir" ]; then
    # Write directory name
    echo "Directory: $(basename "$dir")" >> "$output_file"

    # Write the total number of files
    total_files=$(find "$dir" -type f | wc -l)
    echo "Total files: $total_files" >> "$output_file"

    # Write the number of files with "Michael"
    michael_files=$(find "$dir" -type f -iname '*michael*' | wc -l)
    echo "Files with 'Michael': $michael_files" >> "$output_file"

    # Check for "financials" and extract unique values from "pokemon"
    financials_dir=$(find "$dir" -type d -name 'financials' | head -n 1)
    if [ -n "$financials_dir" ]; then
      pokemon_file=$(find "$financials_dir" -type f -name 'pokemon' | head -n 1)
      if [ -n "$pokemon_file" ]; then
        unique_values=$(cut -f2 "$pokemon_file" | sort | uniq)
        echo "Unique values in 'pokemon': $unique_values" >> "$output_file"
      fi
    fi

    # Blank line for separation
    echo "" >> "$output_file"
  fi
done
