ARG VERSION=buster
ARG WORDPRESS_DATABASE_NAME=wordpress_42
ARG MYSQL_PASSWORD=password

FROM debian:$VERSION
RUN apt update -y && apt upgrade -y
RUN apt-get install nginx mariadb-server mariadb-client php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git -y
RUN service nginx start

#RUN service php7.3-fpm start
#RUN service mysql start
#RUN service mysql status

COPY ./srcs/mariadb.sh ./
COPY ./srcs/default ./
COPY ./srcs/index.html ./

CMD bash mariadb.sh
