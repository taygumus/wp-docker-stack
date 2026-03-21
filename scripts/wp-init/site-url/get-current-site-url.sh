#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh
. /scripts/wp-cli/check-wp-path.sh
. /scripts/wp-cli/check-wp-cli.sh
. /scripts/wp-cli/check-wp-installed.sh
. /scripts/db-common/wait-for-db.sh

REQUIRED_VARS="WORDPRESS_DB_HOST WORDPRESS_DB_NAME WORDPRESS_DB_USER WORDPRESS_DB_PASSWORD \
  WORDPRESS_PATH"

check_required_vars "$REQUIRED_VARS"

check_wp_path
check_wp_cli

# shellcheck disable=SC2119
wait_for_db
check_wp_installed || exit 0

CURRENT_SITE_URL=$(wp option get siteurl --allow-root 2>/dev/null || true)

if [ -z "$CURRENT_SITE_URL" ]; then
  echo "Error: unable to detect current site URL from database" >&2
  exit 1
fi

echo "Detected current site URL: ${CURRENT_SITE_URL}"

readonly CURRENT_SITE_URL
export CURRENT_SITE_URL
