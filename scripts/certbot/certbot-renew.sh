#!/bin/sh
set -e

. /scripts/certbot/lib/terminate.sh

CERTBOT_RENEW_INTERVAL="${CERTBOT_RENEW_INTERVAL:-12h}"

trap terminate TERM INT

echo "[$(date)] Certbot renewal service started"
echo "[$(date)] Renewal interval: ${CERTBOT_RENEW_INTERVAL}"

while true; do
  echo "[$(date)] Checking certificates..."

  if certbot renew --webroot -w /var/www/certbot --quiet; then
    echo "[$(date)] Renewal check completed"
  else
    echo "[$(date)] Renewal failed"
  fi

  echo "[$(date)] Waiting ${CERTBOT_RENEW_INTERVAL} for next check..."
  sleep "${CERTBOT_RENEW_INTERVAL}"
done
