#!/bin/sh
set -e

if [ "${SKIP_WP_INIT}" = "true" ]; then
  echo "WP initialization skipped"
  exit 0
fi

if [ ! -x /scripts/wp-init/run-wp-init.sh ]; then
  echo "Error: run-wp-init.sh not found or not executable" >&2
  exit 1
fi

echo "Running WP initialization tasks"
/scripts/wp-init/run-wp-init.sh
echo "WP initialization completed"
