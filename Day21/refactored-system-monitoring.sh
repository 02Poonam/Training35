#!/bin/bash

# Configuration
LOG_DIR="/var/log/myapp"
LOG_FILE="/var/log/refactored-system-monitoring.log"
MAX_LOG_SIZE=1000000
RETENTION_DAYS=30

# Create or clear the report file
echo "System Monitoring Report - $(date)" > $LOG_FILE

# Function to check disk usage
check_disk_usage() {
    echo "Disk Usage Check - $(date)" >> $LOG_FILE
    if ! df -h >> $LOG_FILE 2>&1; then
        echo "Error: Failed to retrieve disk usage" >> $LOG_FILE
    fi
    echo "-----------------------------" >> $LOG_FILE
}

# Function to check memory usage
check_memory_usage() {
    echo "Memory Usage Check - $(date)" >> $LOG_FILE
    if ! free -h >> $LOG_FILE 2>&1; then
        echo "Error: Failed to retrieve memory usage" >> $LOG_FILE
    fi
    echo "-----------------------------" >> $LOG_FILE
}

# Function to check CPU load
check_cpu_load() {
    echo "CPU Load Check - $(date)" >> $LOG_FILE
    if ! uptime >> $LOG_FILE 2>&1; then
        echo "Error: Failed to retrieve CPU load" >> $LOG_FILE
    fi
    echo "-----------------------------" >> $LOG_FILE
}

# Function to rotate logs
rotate_logs() {
    echo "Checking log files in $LOG_DIR" >> $LOG_FILE
    for log_file in "$LOG_DIR"/*.log; do
        if [ -f "$log_file" ]; then
            log_size=$(stat -c%s "$log_file")
            if [ $log_size -ge $MAX_LOG_SIZE ]; then
                echo "Rotating $log_file" >> $LOG_FILE
                if ! mv "$log_file" "$log_file.old"; then
                    echo "Error: Failed to rotate $log_file" >> $LOG_FILE
                    continue
                fi
                if ! gzip "$log_file.old"; then
                    echo "Error: Failed to compress $log_file.old" >> $LOG_FILE
                    continue
                fi
                echo "$log_file rotated and compressed" >> $LOG_FILE
            fi
        else
            echo "Warning: Log file $log_file does not exist" >> $LOG_FILE
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    echo "Deleting logs older than $RETENTION_DAYS days" >> $LOG_FILE
    find "$LOG_DIR" -name "*.log.gz" -type f -mtime +$RETENTION_DAYS -exec rm {} \; -exec echo "{} deleted" >> $LOG_FILE \;
}

# Main script execution
{
    check_disk_usage
    check_memory_usage
    check_cpu_load
    rotate_logs
    delete_old_logs
    echo "System monitoring and log management completed on $(date)" >> $LOG_FILE
} || {
    echo "Error: System monitoring script failed" >> $LOG_FILE
}
