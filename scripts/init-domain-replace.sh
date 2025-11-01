#!/bin/sh
set -e

OLD_DOMAIN="${OLD_DOMAIN:-example.com}"
NEW_DOMAIN="${NEW_DOMAIN:-localhost:8000}"

DB_HOST="${WORDPRESS_DB_HOST%:*}"
DB_PORT="${WORDPRESS_DB_HOST#*:}"

echo "Starting domain replacement: $OLD_DOMAIN → $NEW_DOMAIN"
echo "Waiting for database at ${DB_HOST}:${DB_PORT}..."

until nc -z "$DB_HOST" "$DB_PORT"; do
  echo "Database not ready yet..."
  sleep 3
done

echo "Database port is open. Giving it a few more seconds..."
sleep 5

echo "Running WP-CLI search-replace..."
wp search-replace "$OLD_DOMAIN" "$NEW_DOMAIN" \
  --skip-columns=guid \
  --all-tables \
  --precise \
  --allow-root \
  || echo "Warning: WP-CLI command failed."

echo "Domain replacement complete."
