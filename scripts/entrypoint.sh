#!/bin/sh
set -e

if [ "${SKIP_WP_TASKS}" = "true" ]; then
  echo "WP tasks skipped"
else
  if [ -x /scripts/run-wp-tasks.sh ]; then
    echo "Running WP tasks"
    /scripts/run-wp-tasks.sh
    echo "WP tasks completed"
  else
    echo "Warning: run-wp-tasks.sh not found or not executable"
  fi
fi

echo "WP-CLI ready for manual commands"
tail -f /dev/null
