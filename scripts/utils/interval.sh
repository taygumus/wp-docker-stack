#!/bin/sh

parse_interval() {
    _value="$1"
    case "$_value" in
        *s) echo "${_value%s}" ;;
        *m) echo "$(( ${_value%m} * 60 ))" ;;
        *h) echo "$(( ${_value%h} * 3600 ))" ;;
        *d) echo "$(( ${_value%d} * 86400 ))" ;;
        *) echo "$_value" ;;
    esac
}

format_interval() {
    _seconds="$1"
    if [ "$_seconds" -lt 60 ]; then
        echo "${_seconds}s"
    elif [ "$_seconds" -lt 3600 ]; then
        echo "$((_seconds / 60))m"
    elif [ "$_seconds" -lt 86400 ]; then
        echo "$((_seconds / 3600))h"
    else
        echo "$((_seconds / 86400))d"
    fi
}
