#!/bin/sh

check_wp_installed() {
  if [ "${WP_INSTALLED_READY}" = "true" ]; then
    return 0
  fi

  if ! wp core is-installed --allow-root >/dev/null 2>&1; then
    echo "WordPress is not installed in the database"
    return 1
  fi

  export WP_INSTALLED_READY=true
  echo "WordPress database is available"
}
