#!/bin/sh

create_db_client_config() {
  _db_host="${1:-database}"
  _db_port="${2:-3306}"
  _db_user="${3}"
  _db_password="${4}"

  cat > /root/.my.cnf <<EOF
[client]
host=${_db_host}
port=${_db_port}
user=${_db_user}
password=${_db_password}
EOF

  chmod 600 /root/.my.cnf
  echo "Created /root/.my.cnf"
}
