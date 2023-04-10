FROM debian:buster
COPY conf conf
COPY tools tools

RUN apt-get update
RUN apt-get install openssl nginx -y

RUN mkdir /etc/nginx/ssl/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/jhii.key -out /etc/nginx/ssl/jhii.crt -config conf/openssl.conf

EXPOSE 443
CMD ["nginx", "-p", ".", "-c", "conf/nginx.conf"]