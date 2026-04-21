pecl install xdebug-2.7.2 
docker-php-ext-enable xdebug 
echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.remote_connect_back=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.remote_port=\${XDEBUG_REMOTE_PORT}" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.remote_log=/var/www/html/storage/logs/xdebug-\${XDEBUG_REMOTE_PORT}.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
echo "xdebug.idekey=VSCODE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 
touch /var/www/html/xdebug.log
chmod 666 /var/www/html/xdebug.log

