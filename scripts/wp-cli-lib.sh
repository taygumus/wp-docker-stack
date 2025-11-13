#!/bin/sh

check_required_vars() {
  REQUIRED_VARS="$1"
  for VAR in $REQUIRED_VARS; do
    if [ -z "$(eval echo \$$VAR)" ]; then
      echo "Error: missing required variable: $VAR"
      exit 1
    fi
  done
}

check_wp_path() {
  if [ -z "$WORDPRESS_PATH" ]; then
    echo "Error: WORDPRESS_PATH is not set"
    exit 1
  fi

  if [ ! -d "$WORDPRESS_PATH" ]; then
    echo "Error: WordPress path '$WORDPRESS_PATH' does not exist"
    exit 1
  fi

  cd "$WORDPRESS_PATH"
}

check_wp_cli() {
  if [ "${WP_CLI_READY}" = "true" ]; then
    return 0
  fi

  if ! command -v wp >/dev/null 2>&1; then
    echo "Error: WP-CLI is not installed or not in PATH"
    exit 1
  fi

  export WP_CLI_READY=true
  echo "WP-CLI is available"
}

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
