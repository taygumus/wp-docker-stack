#!/bin/sh
set -e

. /scripts/wpcli-lib.sh

check_required_vars "CURRENT_SITE_URL SITE_URL"
check_wpcli

wait_for_db

echo "Starting site URL update: ${CURRENT_SITE_URL} → ${SITE_URL}"

if wp search-replace "$CURRENT_SITE_URL" "$SITE_URL" \
  --skip-columns=guid \
  --all-tables \
  --precise \
  --allow-root; then
  echo "Site URL update completed successfully"
else
  echo "Warning: WP-CLI command failed or returned non-zero exit code"
fi
