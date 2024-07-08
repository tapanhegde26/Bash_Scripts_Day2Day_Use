#!/bin/bash

username="testuser"

# Check if user exists, if not, create new user
if getent passwd "$username" > /dev/null 2>&1; then
  echo "User $username already exists!"
else
  useradd -m "$username"
  echo "User with username = $username created"
fi
