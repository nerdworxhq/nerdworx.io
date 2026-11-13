set -e

# cap parallel compile jobs so low-memory builders don't OOM-kill cc1
PIE_MAKE_JOBS="${PIE_MAKE_JOBS:-2}"

echo "Installing mcrypt extension..."
pie install -j"${PIE_MAKE_JOBS}" pecl/mcrypt

# Install php-redis via PIE
echo "Installing redis extension..."
pie install -j"${PIE_MAKE_JOBS}" phpredis/phpredis

# Install the php extensions needed by the app
echo "Installing core PHP extensions..."
docker-php-ext-install zip \
                       pdo_mysql \
                       ldap \
                       gd

echo "All PHP extensions installed successfully!"