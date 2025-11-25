#!/bin/sh

wait_for_db() {
  local db_host="${1:-database}"
  local db_port="${2:-3306}"

  if [ "${DB_READY}" = "true" ]; then
    echo "Database already ready, skipping check"
    return 0
  fi

  echo "Checking database connection at ${db_host}:${db_port}"
  until nc -z "$db_host" "$db_port"; do
    echo "Database not ready, retrying in 3 seconds..."
    sleep 3
  done

  export DB_READY=true
  echo "Database connection established"
}
