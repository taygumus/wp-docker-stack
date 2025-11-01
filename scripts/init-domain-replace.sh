#!/bin/sh
set -e

OLD_DOMAIN="${OLD_DOMAIN:-example.com}"
NEW_DOMAIN="${SITE_URL}"

DB_HOST="${WORDPRESS_DB_HOST%:*}"
DB_PORT="${WORDPRESS_DB_HOST#*:}"

echo "Starting WordPress domain replacement"
echo "Old domain: ${OLD_DOMAIN}"
echo "New domain: ${NEW_DOMAIN}"

echo "Waiting for database connection at ${DB_HOST}:${DB_PORT}"
until nc -z "$DB_HOST" "$DB_PORT"; do
  echo "Database not ready, retrying in 3 seconds"
  sleep 3
done

echo "Database connection established. Waiting before running WP-CLI"
sleep 5

echo "Running WP-CLI search-replace command"
if wp search-replace "$OLD_DOMAIN" "$NEW_DOMAIN" \
  --skip-columns=guid \
  --all-tables \
  --precise \
  --allow-root; then
  echo "Domain replacement completed successfully"
else
  echo "Warning: WP-CLI command failed or returned a non-zero exit code"
fi

echo "Domain replacement script finished"
