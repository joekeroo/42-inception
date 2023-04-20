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
	sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/localhost/srcs_mariadb_1/" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s#/run/php/php7.3-fpm.sock#9000#" /etc/php/7.3/fpm/pool.d/www.conf

	cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
	chown -R www-data:www-data /var/www/html/wordpress/wp-config.php

fi

exec "$@"