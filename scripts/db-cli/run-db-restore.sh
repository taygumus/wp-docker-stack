#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh
. /scripts/db-common/create-db-client-config.sh

FILE="$1"

if [ -z "$FILE" ]; then
  echo "Error: no SQL file provided" >&2
  exit 1
fi

BASE="/db/init"
SQL_PATH="$BASE/$FILE"

if [ ! -f "$SQL_PATH" ]; then
  echo "Error: SQL file not found: $SQL_PATH" >&2
  exit 1
fi

check_required_vars "MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD"

DB_HOST="${MYSQL_HOST:-database}"
DB_PORT="${MYSQL_PORT:-3306}"

echo "Creating DB client config"
create_db_client_config "$DB_HOST" "$DB_PORT" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Restoring $FILE into database $MYSQL_DATABASE..."
mysql "$MYSQL_DATABASE" < "$SQL_PATH"

echo "Database restore completed successfully"
