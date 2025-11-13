#!/bin/sh
set -e

if [ "${SKIP_WP_INIT}" = "true" ]; then
  echo "WP initialization skipped"
else
  if [ -x /scripts/run-wp-init.sh ]; then
    echo "Running WP initialization tasks"
    /scripts/run-wp-init.sh
    echo "WP initialization completed"
  else
    echo "Warning: run-wp-init.sh not found or not executable"
  fi
fi
