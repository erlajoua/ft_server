#script pour mariadb
service php7.3-fpm start
service mysql start

echo "CREATE DATABASE wpdb;" | mysql -u root --skip-password
echo "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#start moving
rm /var/www/html/index.nginx-debian.html
mv /var/www/html/phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin

#accueil
mv ./index.php /var/www/html/
mv ./style.css /var/www/html/
mv ./logogit.png /var/www/html/
cp ./off.sh /var/www/html/

rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
mv ./default /var/www/html/
ln -s /var/www/html/default /etc/nginx/sites-enabled/

#clef ssl
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 1 -nodes -out /etc/nginx/ssl/website.pem -keyout /etc/nginx/ssl/website.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=erlajoua/CN=website"

#config 
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i 's/database_name_here/wpdb/g' /var/www/html/wordpress/wp-config.php ;
sed -i 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php ;
sed -i 's/password_here/dbpassword/g' /var/www/html/wordpress/wp-config.php ;
chown -R www-data:www-data /var/www/html/wordpress
service nginx restart
service php7.3-fpm restart
cd /etc/nginx/sites-enabled/

bash
