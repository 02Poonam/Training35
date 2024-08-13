#!/bin/bash

# Configuration
LOG_DIR="/var/log/myapp"                # Directory where logs are stored
MAX_LOG_SIZE=1000000                   # Maximum log size in bytes (e.g., 1MB)
RETENTION_DAYS=30                     # Number of days to retain old logs
REPORT_FILE="/var/log/log_management_report.log"  # Report file location

# Create or clear the report file
echo "Log Management Report - $(date)" > $REPORT_FILE

# Function to rotate logs
rotate_logs() {
    echo "Checking log files in $LOG_DIR" >> $REPORT_FILE
    for log_file in $LOG_DIR/*.log; do
        if [ -f "$log_file" ]; then
            log_size=$(stat -c%s "$log_file")
            if [ $log_size -ge $MAX_LOG_SIZE ]; then
                echo "Rotating $log_file" >> $REPORT_FILE
                mv "$log_file" "$log_file.old"
                gzip "$log_file.old"
                echo "$log_file rotated and compressed" >> $REPORT_FILE
            fi
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    echo "Deleting logs older than $RETENTION_DAYS days" >> $REPORT_FILE
    find $LOG_DIR -name "*.log.gz" -type f -mtime +$RETENTION_DAYS -exec rm {} \; -exec echo "{} deleted" >> $REPORT_FILE \;
}

# Run the log rotation and deletion
rotate_logs
delete_old_logs

echo "Log management completed on $(date)" >> $REPORT_FILE
