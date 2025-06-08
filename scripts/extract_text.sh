#!/bin/bash

# extract_text.sh - Extract text from PDF or copy existing text file
# Usage: ./extract_text.sh input_file output_dir

set -e

input_file="$1"
output_dir="$2"
filename=$(basename "$input_file")
extension="${filename##*.}"
basename="${filename%.*}"

mkdir -p "$output_dir"

# If it's a text file, simply copy it
if [ "$extension" = "txt" ]; then
  echo "Copying $filename..."
  cp "$input_file" "$output_dir/$basename.txt"
  exit 0
fi

# If it's a PDF, try to extract text
if [ "$extension" = "pdf" ]; then
  echo "Extracting text from $filename..."
  
  # Try pdftotext if available
  if command -v pdftotext &> /dev/null; then
    if pdftotext -layout "$input_file" "$output_dir/$basename.txt" 2>/dev/null; then
      echo "  Extraction successful"
      exit 0
    fi
  fi
  
  # Fallback if pdftotext fails or is not available
  echo "Warning: Could not extract text from PDF using pdftotext."
  echo "PDF text extraction requires poppler-utils to be installed." > "$output_dir/$basename.txt"
  echo "File: $filename" >> "$output_dir/$basename.txt"
  exit 0
fi

# For other file types
echo "Unsupported file type: $extension"
echo "Unsupported file type: $extension" > "$output_dir/$basename.txt"
exit 0