#!/bin/sh
set -e

. /scripts/wp-cli/check-wp-path.sh
. /scripts/wp-cli/check-wp-cli.sh
. /scripts/db/wait-for-db.sh

check_wp_path
check_wp_cli

# shellcheck disable=SC2119
wait_for_db

CURRENT_SITE_URL=$(wp option get siteurl --allow-root 2>/dev/null || true)

if [ -z "$CURRENT_SITE_URL" ]; then
  echo "Error: unable to detect current site URL from database"
  exit 1
fi

echo "Detected current site URL: ${CURRENT_SITE_URL}"

readonly CURRENT_SITE_URL
export CURRENT_SITE_URL
