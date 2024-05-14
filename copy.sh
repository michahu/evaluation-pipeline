#!/bin/bash

# Define the directory containing subdirectories
main_dir="./models/ltgbert_base"

# Define the files to be copied
# files=("./models/ltgbert_10M/ltgbert_10M-200-10/config.json" "./models/ltgbert_10M/ltgbert_10M-200-10/special_tokens_map.json" "./models/ltgbert_10M/ltgbert_10M-200-10/tokenizer_config.json")
files=("./models/ltgbert_external/config.json" "./models/ltgbert_external/special_tokens_map.json" "./models/ltgbert_external/tokenizer_config.json")

# Iterate over subdirectories
for subdir in "$main_dir"/*/; do
    subdir="${subdir%/}"  # Remove trailing slash
    echo "Copying files to $subdir..."
    # Copy files to the subdirectory
    cp -v "${files[@]}" "$subdir"
done
