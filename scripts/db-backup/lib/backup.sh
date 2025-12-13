#!/bin/sh

do_backup() {
    _db_name=$1
    _backup_dir=$2

    _timestamp=$(date +"%Y%m%d-%H%M%S")
    _file="$_backup_dir/backup-$_timestamp.sql"

    echo "Executing backup: $_file"
    mysqldump --no-tablespaces "$_db_name" > "$_file"

    echo "Backup completed: $_file"
}
