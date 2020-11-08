#script pour mariadb

service php7.3-fpm start
service mysql start
service mysql status

echo "CREATE DATABASE wpdb;" | mysql -u root --skip-password
echo "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#else

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
mv ./wordpress.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/
service nginx restart
service php7.3-fpm reload

bash
