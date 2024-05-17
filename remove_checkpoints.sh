#!/bin/bash

# Function to remove .safetensor files
remove_safetensor_files() {
    # Use find command to locate .safetensor files recursively
    find "$1"  -type f -name '*.safetensors' -exec rm -f {} +
}

# Specify the directory to start searching for .safetensor files
directory_to_search=$1

# Call the function to remove .safetensor files
remove_safetensor_files "$directory_to_search"