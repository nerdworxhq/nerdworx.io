echo "Installing mcrypt extension..."
pie install pecl/mcrypt
docker-php-ext-enable mcrypt

# Install php-redis via PIE
echo "Installing redis extension..."
pie install phpredis/phpredis
docker-php-ext-enable redis

# Install opcache (built-in extension)
echo "Installing opcache..."
docker-php-ext-install opcache

# Install the php extensions needed by the app
echo "Installing core PHP extensions..."
docker-php-ext-install zip \
                       pdo_mysql \
                       pdo_pgsql \
                       ldap \
                       gd

echo "All PHP extensions installed successfully!"