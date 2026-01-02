#!/bin/sh
set -e

if [ "${SKIP_CERTBOT}" = "true" ]; then
  echo "Certbot service skipped"
  exit 0
fi

if [ ! -x /scripts/certbot/certbot-renew.sh ]; then
  echo "Error: certbot-renew.sh not found or not executable"
  exit 1
fi

echo "Starting Certbot renewal service"
/scripts/certbot/certbot-renew.sh
