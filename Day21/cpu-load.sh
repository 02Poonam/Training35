#!/bin/bash

# Define log file
LOG_FILE="/var/log/cpu-load.log"

# Timestamp
echo "CPU Load Check - $(date)" >> $LOG_FILE

# Check CPU load
uptime >> $LOG_FILE 2>&1

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve CPU load" >> $LOG_FILE
fi

echo "-----------------------------" >> $LOG_FILE
