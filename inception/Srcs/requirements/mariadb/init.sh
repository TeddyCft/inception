#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mariadbd --user=mysql --datadir=/var/lib/mysql &
    PID=$!
    until mariadb-admin ping --silent; do
        echo "Waiting for MariaDB startup..."
        sleep 1
    done

    mariadb -uroot << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    mariadb-admin -uroot shutdown
fi

exec mariadbd  --user=mysql --datadir=/var/lib/mysql