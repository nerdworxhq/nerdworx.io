FROM registry.nerdwrks.net/nerdwrks/nerdwrks-php:v1.0.0

# set the operating user for php 
USER www-data:www-data

#copy in the keys for composer packages for this app
WORKDIR /home/www-data/.ssh/
COPY --chown=www-data:www-data .docker/php/keys .
RUN chmod 600 /home/www-data/.ssh/*

#  switch to the folder with the code and copy the specific files
WORKDIR /var/www/html
COPY --chown=www-data:www-data composer.json composer.json
COPY --chown=www-data:www-data vite.config.ts vite.config.ts
COPY --chown=www-data:www-data package.json package.json
COPY --chown=www-data:www-data server.php server.php
COPY --chown=www-data:www-data phpunit.xml phpunit.xml
COPY --chown=www-data:www-data artisan artisan
COPY --chown=www-data:www-data bootstrap/app.php bootstrap/app.php

# copy the folders
COPY --chown=www-data:www-data public public
COPY --chown=www-data:www-data app app
COPY --chown=www-data:www-data config config
COPY --chown=www-data:www-data database database
COPY --chown=www-data:www-data resources resources
COPY --chown=www-data:www-data routes routes
COPY --chown=www-data:www-data storage storage
COPY --chown=www-data:www-data tests tests

RUN touch /var/www/html/storage/logs/laravel.log && \
    chown www-data:www-data /var/www/html/storage/logs/laravel.log && \
    chmod -R 777 /var/www/html/storage/logs/

# install php dependencies, and install npm dependencies
RUN composer install --no-dev --no-scripts --no-plugins --ignore-platform-reqs && \
    php artisan key:generate --force
    # npm install && \
    # npm run prod
    # TODO: leaving this here to remind us that we need to rework where the APP_KEY is held
    # rm -f .env && \
