#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3
BACKUP_DIR=$4
DATE=$(date +%Y%m%d)
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${DATE}.sql.gz"

# Create backup
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME | gzip > $BACKUP_FILE

# Optional: Remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.gz" -mtime +7 -exec rm {} \;

