curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
cp /tmp/.tmp/.env.initial /var/www/html/.env 
chown www-data:www-data /var/www/html/.env