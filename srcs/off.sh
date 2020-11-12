sed -i 's/autoindex on/autoindex off/g' def
sed -i 's/index index.html index.htm index.php/index index.html index.htm/g' def
service nginx restart
