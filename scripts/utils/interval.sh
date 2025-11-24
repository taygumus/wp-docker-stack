#!/bin/sh

parse_interval() {
    local value="$1"
    case "$value" in
        *s) echo "${value%s}" ;;
        *m) echo "$(( ${value%m} * 60 ))" ;;
        *h) echo "$(( ${value%h} * 3600 ))" ;;
        *d) echo "$(( ${value%d} * 86400 ))" ;;
        *) echo "$value" ;;
    esac
}

format_interval() {
    local seconds="$1"
    if [ "$seconds" -lt 60 ]; then
        echo "${seconds}s"
    elif [ "$seconds" -lt 3600 ]; then
        echo "$((seconds / 60))m"
    elif [ "$seconds" -lt 86400 ]; then
        echo "$((seconds / 3600))h"
    else
        echo "$((seconds / 86400))d"
    fi
}
