#!/bin/sh

if [ -d /var/www/html/wordpress ]; then
	echo "wordpress exists"
else
	cd tools/
	wget https://wordpress.org/latest.tar.gz
	tar -xvf latest.tar.gz
	cp -R wordpress ../var/www/html/
	cd ..

	chmod -R 777 /var/www/html/
	chown -R www-data:www-data /var/www/html/wordpress/
	mkdir /var/www/html/wordpress/wp-content/uploads
	chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/

	sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/username_here/$MYSQL_ADMIN_USER/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_ADMIN_PASSWORD/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/localhost/mariadb/" /var/www/html/wordpress/wp-config-sample.php

	cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
	chown -R www-data:www-data /var/www/html/wordpress/wp-config.php

	cd /var/www/html/wordpress/
	wp core install --allow-root --url=localhost --title="Word from Admins" --admin_name=superuser --admin_password=superuser123 --admin_email=superuser@gmail.com
	wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --user_pass=$WORDPRESS_PASSWORD --display_name=$WORDPRESS_USER --role=author --allow-root
	cd ../../../..
fi

sed -i "s#/run/php/php7.3-fpm.sock#9000#" /etc/php/7.3/fpm/pool.d/www.conf

exec "$@"