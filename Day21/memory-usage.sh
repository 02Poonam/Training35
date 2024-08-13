#!/bin/bash

# Define log file
LOG_FILE="/var/log/memory-usage.log"

# Timestamp
echo "Memory Usage Check - $(date)" >> $LOG_FILE

# Check memory usage
free -h >> $LOG_FILE 2>&1

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve memory usage" >> $LOG_FILE
fi

echo "-----------------------------" >> $LOG_FILE
