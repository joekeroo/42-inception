FROM debian:buster
COPY conf conf
COPY tools tools

RUN "apt-get" "update"
RUN "apt" "install" "nginx" "-y"
RUN "apt" "install" "ufw" "-y"

RUN "ufw" "allow" "443"

CMD ["nginx", "-p", ".", "-c", "conf/default.conf"]
