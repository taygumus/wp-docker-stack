#!/bin/sh

. /scripts/utils/check-required-vars.sh

create_db_client_config() {
    local db_host="${1:-database}"
    local db_port="${2:-3306}"
    local db_user="${3}"
    local db_password="${4}"

    check_required_vars "db_user db_password"

    cat > /root/.my.cnf <<EOF
[client]
host=${db_host}
port=${db_port}
user=${db_user}
password=${db_password}
EOF

    chmod 600 /root/.my.cnf
    echo "Created /root/.my.cnf"
}
