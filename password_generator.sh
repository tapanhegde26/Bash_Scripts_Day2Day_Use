#!/bin/bash

length=15

# Generate Random password and truncate to desired length
password=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | head -c $length)
echo "Generated Password : $password"
