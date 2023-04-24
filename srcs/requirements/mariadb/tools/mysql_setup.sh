#!/bin/sh

if [ -d /var/lib/mysql/$MYSQL_DATABASE ]; then
	echo "Database exists"
else
	mysql_install_db --user=mysql
	echo "USE mysql;" > /tools/setup.sql
	echo "DELETE FROM mysql.user WHERE User='';" >> /tools/setup.sql
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost');" >> /tools/setup.sql
	echo "FLUSH PRIVILEGES;" >> /tools/setup.sql

	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /tools/setup.sql
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> /tools/setup.sql
	echo "CREATE USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" >> /tools/setup.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" >> /tools/setup.sql
	echo "FLUSH PRIVILEGES;" >> /tools/setup.sql

	echo "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" >> /tools/setup.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" >> /tools/setup.sql
	echo "FLUSH PRIVILEGES;" >> /tools/setup.sql

	mysqld --user=mysql --bootstrap < /tools/setup.sql
	sed -i "s#127.0.0.1#mariadb#" /etc/mysql/mariadb.conf.d/50-server.cnf
fi

exec "$@"