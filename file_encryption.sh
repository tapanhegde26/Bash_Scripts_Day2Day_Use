#!/bin/bash

file="/path/to/file.txt"

# Check if file exists
if [[ ! -f "$file" ]]; then
  echo "Error: File not found!"
  exit 1
fi

# Encrypt file using AES-256-CBC
openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc"
if [[ $? -eq 0 ]]; then
  echo "File encrypted: $file.enc"
else
  echo "Error: Encryption failed!"
  exit 1
fi
