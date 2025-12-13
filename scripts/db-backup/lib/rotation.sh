#!/bin/sh

rotate_backups() {
    _backup_dir="$1"
    _max_files="$2"

    _count=$(find "$_backup_dir" -maxdepth 1 -type f -name '*.sql' | wc -l | tr -d ' ')

    if [ "$_count" -gt "$_max_files" ]; then
        _remove=$((_count - _max_files))
        echo "Limit exceeded ($_count > $_max_files). Removing $_remove oldest backup(s)"

        find "$_backup_dir" -maxdepth 1 -type f -name '*.sql' -print0 \
            | xargs -0 stat --printf '%Y %n\n' \
            | sort -n \
            | head -n "$_remove" \
            | cut -d' ' -f2- \
            | xargs rm -f
    fi
}
