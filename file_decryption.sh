#!/bin/bash

encrypted_file="/path/to/file.txt.enc"
output_file="/path/to/decrypted_file.txt"

# Check if encrypted file exists
if [[ ! -f "$encrypted_file" ]]; then
  echo "Error: Encrypted file not found!"
  exit 1
fi

# Decrypt file using AES-256-CBC
openssl enc -d -aes-256-cbc -in "$encrypted_file" -out "$output_file"
if [[ $? -eq 0 ]]; then
  echo "File decrypted: $output_file"
else
  echo "Error: Decryption failed!"
  exit 1
fi
