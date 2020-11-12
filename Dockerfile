ARG VERSION=buster

FROM debian:$VERSION
RUN apt update -y && apt upgrade -y
RUN apt-get install vim nginx mariadb-server mariadb-client php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git -y

WORKDIR /var/www/html
RUN chown -R www-data:www-data *
RUN chmod 755 -R *
RUN service nginx start

WORKDIR /
COPY ./srcs/mariadb.sh ./
COPY ./srcs/default ./
COPY ./srcs/index.php ./
COPY ./srcs/style.css ./
COPY ./srcs/logogit.png ./
COPY ./srcs/off.sh ./

ADD ./srcs/phpMyAdmin-4.9.0.1-all-languages.tar.gz /var/www/html/
ADD ./srcs/latest.tar.gz /var/www/html/

CMD bash mariadb.sh
