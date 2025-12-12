#!/bin/sh
set -e

. /scripts/db/create-db-client-config.sh
. /scripts/db-backup/lib/backup.sh

DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backups"

echo "Creating DB client config"
create_db_client_config "${MYSQL_HOST:-}" "${MYSQL_PORT:-}" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Running one-shot backup..."
do_backup "$DB_NAME" "$BACKUP_DIR"

echo "Backup completed"
