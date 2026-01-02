#!/bin/sh
set -e

if [ "${SKIP_CERTBOT_TASKS}" = "true" ]; then
  echo "Certbot tasks skipped"
  exit 0
fi

if [ ! -x /scripts/certbot/execute-certbot-tasks.sh ]; then
  echo "Error: execute-certbot-tasks.sh not found or not executable"
  exit 1
fi

echo "Executing certbot tasks"
/scripts/certbot/execute-certbot-tasks.sh
