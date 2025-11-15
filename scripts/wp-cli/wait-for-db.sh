#!/bin/sh

. /scripts/utils/check-required-vars.sh

wait_for_db() {
  if [ "${DB_READY}" = "true" ]; then
    return 0
  fi

  check_required_vars "WORDPRESS_DB_HOST WORDPRESS_DB_NAME WORDPRESS_DB_USER WORDPRESS_DB_PASSWORD"

  DB_HOST="${WORDPRESS_DB_HOST%:*}"
  DB_PORT="${WORDPRESS_DB_HOST#*:}"

  echo "Checking database connection at ${DB_HOST}:${DB_PORT}"
  until nc -z "$DB_HOST" "$DB_PORT"; do
    echo "Database not ready, retrying in 3 seconds"
    sleep 3
  done

  export DB_READY=true
  echo "Database connection established"
}
