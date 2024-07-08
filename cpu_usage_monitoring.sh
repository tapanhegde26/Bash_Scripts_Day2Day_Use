#!/bin/bash

threshold=60
email="example@example.com"  # Replace with your DL group's email address
subject="High CPU Usage Alert"
body="CPU usage has exceeded the threshold of $threshold%. Current usage: "

# Monitor CPU usage and send alerts if threshold exceeds
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage_int=$(printf "%.0f" $cpu_usage)

if [ "$cpu_usage_int" -gt "$threshold" ]; then
    echo "$body $cpu_usage_int%" | mail -s "$subject" "$email"
fi
