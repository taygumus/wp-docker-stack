#!/bin/sh
set -e

. /scripts/db-common/create-db-client-config.sh
. /scripts/db-backup/lib/backup.sh

DB_HOST="${MYSQL_HOST:-database}"
DB_PORT="${MYSQL_PORT:-3306}"
DB_NAME="${MYSQL_DATABASE:-wordpress}"

BACKUP_DIR="/backups"

echo "Creating DB client config"
create_db_client_config "$DB_HOST" "$DB_PORT" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Running one-shot backup..."
do_backup "$DB_NAME" "$BACKUP_DIR"

echo "Backup completed"
