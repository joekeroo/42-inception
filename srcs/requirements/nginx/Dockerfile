FROM debian:buster

RUN apt-get update
RUN apt-get install openssl nginx -y
RUN mkdir -p /etc/nginx/ssl/

COPY conf conf
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/jhii.key -out /etc/nginx/ssl/jhii.crt -config conf/openssl.conf

CMD ["nginx", "-p", ".", "-c", "conf/nginx.conf"]