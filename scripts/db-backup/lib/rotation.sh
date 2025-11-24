#!/bin/sh

rotate_backups() {
    local backup_dir="$1"
    local max_files="$2"

    local count
    count=$(ls -1 "$backup_dir"/*.sql 2>/dev/null | wc -l | tr -d ' ')

    if [ "$count" -gt "$max_files" ]; then
        local remove=$((count - max_files))
        echo "Limit exceeded ($count > $max_files). Removing $remove oldest backup(s)"
        ls -1t "$backup_dir"/*.sql | tail -n "$remove" | xargs rm -f
    fi
}
