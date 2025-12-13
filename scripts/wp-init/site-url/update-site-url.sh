#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh
. /scripts/wp-cli/check-wp-path.sh
. /scripts/wp-cli/check-wp-cli.sh
. /scripts/db/wait-for-db.sh

check_required_vars "CURRENT_SITE_URL SITE_URL"

check_wp_path
check_wp_cli

# shellcheck disable=SC2119
wait_for_db

echo "Starting site URL update: ${CURRENT_SITE_URL} → ${SITE_URL}"

SKIP_COLUMNS_FLAG=""
if [ -n "$SKIP_COLUMNS" ]; then
  SKIP_COLUMNS_TRIMMED=$(echo "$SKIP_COLUMNS" | tr -d ' ')
  SKIP_COLUMNS_FLAG="--skip-columns=${SKIP_COLUMNS_TRIMMED}"
  echo "Skipping columns: ${SKIP_COLUMNS_TRIMMED}"
else
  echo "No columns will be skipped"
fi

# shellcheck disable=SC2086
if wp search-replace "$CURRENT_SITE_URL" "$SITE_URL" \
  $SKIP_COLUMNS_FLAG \
  --all-tables \
  --precise \
  --allow-root; then
  echo "Site URL update completed successfully"
else
  echo "Error: WP-CLI command failed"
  exit 1
fi
