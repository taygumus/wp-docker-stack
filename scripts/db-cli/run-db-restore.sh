#!/bin/sh
set -e

. /scripts/db-common/create-db-client-config.sh

FILE="$1"

if [ -z "$FILE" ]; then
    echo "ERROR: No SQL file provided"
    exit 1
fi

BASE="/db/init"
SQL_PATH="$BASE/$FILE"

if [ ! -f "$SQL_PATH" ]; then
    echo "ERROR: SQL file not found: $SQL_PATH"
    exit 1
fi

echo "Creating DB client config"
create_db_client_config "${MYSQL_HOST:-}" "${MYSQL_PORT:-}" "${MYSQL_USER}" "${MYSQL_PASSWORD}"

echo "Restoring $FILE into database $MYSQL_DATABASE..."
mysql "$MYSQL_DATABASE" < "$SQL_PATH"

echo "Database restore completed successfully"
