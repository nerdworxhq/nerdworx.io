#since mcrypt is distributed with pecl now and not in the php install since 7.2, 
#need to go ahead and grab it from there - then enable it 
pecl install mcrypt-1.0.3 
docker-php-ext-enable mcrypt

#install php-redis to avoid predis which is going away
pecl install redis
docker-php-ext-enable redis

#install opcache
docker-php-ext-install opcache

#install the php extensions needed by the app
docker-php-ext-install zip \
                       pdo_mysql \
                       ldap \
                       gd