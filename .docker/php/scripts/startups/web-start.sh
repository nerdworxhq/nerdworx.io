# get rid of the two Artisan commands that could decrypt the secrets from the safe
rm /var/www/html/vendor/laravel/framework/src/Illuminate/Foundation/Console/ConfigCacheCommand.php && \
rm /var/www/html/vendor/beyondcode/laravel-credentials/src/EditCredentialsCommand.php

# start php
php-fpm --fpm-config /usr/local/etc/php-fpm.d/www.conf
