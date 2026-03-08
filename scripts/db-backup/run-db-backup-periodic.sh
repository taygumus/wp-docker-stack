#!/bin/sh
set -e

. /scripts/utils/interval.sh
. /scripts/db-common/create-db-client-config.sh
. /scripts/db-backup/lib/backup.sh
. /scripts/db-backup/lib/rotation.sh

DB_HOST="${MYSQL_HOST:-database}"
DB_PORT="${MYSQL_PORT:-3306}"
DB_NAME="${MYSQL_DATABASE:-wordpress}"

BACKUP_INITIAL_DELAY="${DB_BACKUP_INITIAL_DELAY:-60s}"
BACKUP_INTERVAL="${DB_BACKUP_INTERVAL:-3600s}"
BACKUP_MAX_FILES="${DB_BACKUP_MAX_FILES:-3}"

BACKUP_DIR="/backups"
BACKUP_INITIAL_DELAY_SEC=$(parse_interval "$BACKUP_INITIAL_DELAY")
BACKUP_INTERVAL_SEC=$(parse_interval "$BACKUP_INTERVAL")

echo "Creating DB client config"
create_db_client_config "$DB_HOST" "$DB_PORT" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Initial delay: $(format_interval "$BACKUP_INITIAL_DELAY_SEC")"
sleep "$BACKUP_INITIAL_DELAY_SEC"

while true; do
  do_backup "$DB_NAME" "$BACKUP_DIR"
  rotate_backups "$BACKUP_DIR" "$BACKUP_MAX_FILES"

  echo "Waiting $(format_interval "$BACKUP_INTERVAL_SEC") until next backup..."
  sleep "$BACKUP_INTERVAL_SEC"
done
