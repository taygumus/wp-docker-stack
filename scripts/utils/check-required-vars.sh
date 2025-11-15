#!/bin/sh

check_required_vars() {
  REQUIRED_VARS="$1"
  for VAR in $REQUIRED_VARS; do
    if [ -z "$(eval echo \$$VAR)" ]; then
      echo "Error: missing required variable: $VAR"
      exit 1
    fi
  done
}
