#!/bin/sh

wait_for_db() {
  _db_host="${1:-database}"
  _db_port="${2:-3306}"

  if [ "${DB_READY}" = "true" ]; then
    echo "Database already ready, skipping check"
    return 0
  fi

  echo "Checking database connection at ${_db_host}:${_db_port}"
  retries=60

  while ! nc -z "$_db_host" "$_db_port" >/dev/null 2>&1; do
    retries=$((retries - 1))
    if [ "$retries" -le 0 ]; then
      echo "Error: database not reachable at ${_db_host}:${_db_port}" >&2
      return 1
    fi
    echo "Database not ready, retrying in 3 seconds..."
    sleep 3
  done

  export DB_READY=true
  echo "Database connection established"
}
