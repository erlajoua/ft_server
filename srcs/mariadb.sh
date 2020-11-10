#script pour mariadb

service php7.3-fpm start
service mysql start
service mysql status

echo "CREATE DATABASE wpdb;" | mysql -u root --skip-password
echo "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
#end mariadb

#start moving
rm /var/www/html/index.nginx-debian.html
mv ./index.html /var/www/html/

mv ./default /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

mv ./wordpress.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

mkdir /var/www/html/php
mv ./index.php /var/www/html/php/
mv ./php.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/php.conf /etc/nginx/sites-enabled/
#end moving

#clef ssl
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/website.pem -keyout /etc/nginx/ssl/website.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlajoua/CN=website"
#end sll

mv /latest.tar.gz /var/www/html/
cd /var/www/html/
tar -xvzf latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wpdb/g' /var/www/html/wordpress/wp-config.php ;
sed -i 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php ;
sed -i 's/password_here/dbpassword/g' /var/www/html/wordpress/wp-config.php ;
chown -R www-data:www-data /var/www/html/wordpress
touch /etc/nginx/sites-available/wordpress.conf
cd /
service nginx restart
service php7.3-fpm reload

bash
