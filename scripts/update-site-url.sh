#!/bin/sh
set -e

. /scripts/wpcli-lib.sh

check_required_vars "CURRENT_SITE_URL SITE_URL"
check_wpcli
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

if wp search-replace "$CURRENT_SITE_URL" "$SITE_URL" \
  $SKIP_COLUMNS_FLAG \
  --all-tables \
  --precise \
  --allow-root; then
  echo "Site URL update completed successfully"
else
  echo "Warning: WP-CLI command failed or returned non-zero exit code"
fi
