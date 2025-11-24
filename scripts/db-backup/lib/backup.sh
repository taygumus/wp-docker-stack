#!/bin/sh

do_backup() {
    local db_name="$1"
    local backup_dir="$2"

    local timestamp
    timestamp=$(date +"%Y%m%d-%H%M%S")
    local file="$backup_dir/backup-$timestamp.sql"

    echo "Executing backup: $file"
    mysqldump --no-tablespaces "$db_name" > "$file"
    echo "Backup completed: $file"
}
