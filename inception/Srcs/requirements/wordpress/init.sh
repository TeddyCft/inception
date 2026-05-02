#!/bin/sh
set -e

echo "Starting WordPress init..."

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Waiting for MariaDB..."
    until mariadb -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --ssl=0 -e "SELECT 1" >/dev/null 2>&1; do
        sleep 2
    done
        echo "mariaDB & wordpress ready"

    cd /var/www/html/
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
    sed -i "s/username_here/$DB_USER/g" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$DB_HOST/g" wp-config.php
    #setting the wp-config file to use env variables

    sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf
fi

if ! wp core is-installed --path=/var/www/html; then
    echo "Installing WordPress..."

    wp core install \
      --path=/var/www/html \
      --url="https://tcoeffet.42.fr" \
      --title="Inception Site" \
      --admin_user="$WP_ADMIN_USER" \
      --admin_password="$WP_ADMIN_PASSWORD" \
      --admin_email="$WP_ADMIN_EMAIL" \
      --skip-email
fi

exec php-fpm83 -F

