#!/bin/sh
set -e

. /scripts/utils/interval.sh
. /scripts/db-common/create-db-client-config.sh
. /scripts/db-backup/lib/backup.sh
. /scripts/db-backup/lib/rotation.sh

DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backups"
BACKUP_MAX_FILES="${DB_BACKUP_MAX_FILES}"

BACKUP_INITIAL_DELAY_SEC=$(parse_interval "${DB_BACKUP_INITIAL_DELAY}")
BACKUP_INTERVAL_SEC=$(parse_interval "${DB_BACKUP_INTERVAL}")

echo "Creating DB client config"
create_db_client_config "${MYSQL_HOST:-}" "${MYSQL_PORT:-}" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Initial delay: $(format_interval "$BACKUP_INITIAL_DELAY_SEC")"
sleep "$BACKUP_INITIAL_DELAY_SEC"

while true; do
  do_backup "$DB_NAME" "$BACKUP_DIR"
  rotate_backups "$BACKUP_DIR" "$BACKUP_MAX_FILES"

  echo "Waiting $(format_interval "$BACKUP_INTERVAL_SEC") until next backup..."
  sleep "$BACKUP_INTERVAL_SEC"
done
