#!/bin/sh
set -e

if [ "${SKIP_DB_BACKUP}" = "true" ]; then
  echo "DB backup skipped"
  exit 0
fi

if [ ! -x /scripts/db-backup/run-db-backup.sh ]; then
  echo "Error: run-db-backup.sh not found or not executable"
  exit 1
fi

echo "Starting DB backup service"
/scripts/db-backup/run-db-backup.sh
