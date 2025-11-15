#!/bin/sh

check_wp_cli() {
  if [ "${WP_CLI_READY}" = "true" ]; then
    return 0
  fi

  if ! command -v wp >/dev/null 2>&1; then
    echo "Error: WP-CLI is not installed or not in PATH"
    exit 1
  fi

  export WP_CLI_READY=true
  echo "WP-CLI is available"
}
