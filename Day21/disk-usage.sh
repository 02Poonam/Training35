#!/bin/bash

# Define log file
LOG_FILE="/var/log/disk-usage.log"

# Timestamp
echo "Disk Usage Check - $(date)" >> $LOG_FILE

# Check disk usage
df -h >> $LOG_FILE 2>&1

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve disk usage" >> $LOG_FILE
fi

echo "-----------------------------" >> $LOG_FILE
