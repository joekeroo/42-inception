FROM debian:buster

RUN apt-get update
RUN apt-get install wget tar curl -y
RUN apt-get install php-fpm php-mysql -y
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN wp cli version

RUN mkdir -p /var/run/
RUN mkdir -p /run/php/
RUN mkdir -p /var/www/html/

COPY tools tools
RUN chmod +x /tools/wordpress_setup.sh

ENTRYPOINT [ "./tools/wordpress_setup.sh" ]
CMD [ "usr/sbin/php-fpm7.3", "-F", "-R" ]