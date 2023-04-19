FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:root /var/lib/mysql

COPY tools tools
RUN chmod +x /tools/mysql_setup.sh

EXPOSE 3306
ENTRYPOINT ["./tools/mysql_setup.sh"]
CMD ["mysqld_safe"]