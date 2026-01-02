#!/bin/sh
set -e

. /scripts/certbot/certbot-renew/lib/terminate.sh

CERTBOT_RENEW_INTERVAL="${CERTBOT_RENEW_INTERVAL:-12h}"

trap terminate TERM INT

echo "Certbot renewal service started"
echo "Renewal interval: ${CERTBOT_RENEW_INTERVAL}"

while true; do
  echo "Checking certificates..."

  if certbot renew --webroot -w /var/www/certbot --quiet; then
    echo "Renewal check completed"
  else
    echo "Renewal failed"
  fi

  echo "Waiting ${CERTBOT_RENEW_INTERVAL} for next check..."
  sleep "${CERTBOT_RENEW_INTERVAL}"
done
