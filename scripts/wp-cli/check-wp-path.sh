#!/bin/sh

check_wp_path() {
  if [ -z "$WORDPRESS_PATH" ]; then
    echo "Error: WORDPRESS_PATH is not set"
    exit 1
  fi

  if [ ! -d "$WORDPRESS_PATH" ]; then
    echo "Error: WordPress path '$WORDPRESS_PATH' does not exist"
    exit 1
  fi

  cd "$WORDPRESS_PATH"
}
