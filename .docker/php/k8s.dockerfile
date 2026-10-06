FROM ghcr.io/nerdworxhq/nerdworx.io/nerdworx-io-php-base-85:v1.0.0

# copy the setup scripts
WORKDIR /tmp
COPY .docker/php/scripts .tmp
RUN rm -rf /home/www-data/startups && mv /tmp/.tmp/startups/ /home/www-data/

RUN chmod 777 /tmp/.tmp/*

# set permissions on the php folders to make sure the operating user can get to all the places
RUN chown -R www-data:www-data /usr/local/etc/php-fpm.d/* && \
    chown -R www-data:www-data /usr/local/etc/php/* && \
    chown -R www-data:www-data /home/www-data/* && \
    touch /usr/local/var/log/php-fpm.log && \
    chown www-data:www-data /usr/local/var/log/php-fpm.log

# set the operating user for php
USER www-data:www-data

#copy in the keys for composer packages for this app
#WORKDIR /home/www-data/.ssh/
#COPY --chown=www-data:www-data .docker/php/keys .
#RUN chmod 600 /home/www-data/.ssh/*

#  switch to the folder with the code and copy the specific files
WORKDIR /var/www/html
COPY --chown=www-data:www-data composer.json composer.json
COPY --chown=www-data:www-data composer.lock composer.lock
COPY --chown=www-data:www-data vite.config.ts vite.config.ts
COPY --chown=www-data:www-data package.json package.json
COPY --chown=www-data:www-data phpunit.xml phpunit.xml
COPY --chown=www-data:www-data artisan artisan
COPY --chown=www-data:www-data bootstrap/app.php bootstrap/app.php
COPY --chown=www-data:www-data bootstrap/providers.php bootstrap/providers.php

# copy the folders
COPY --chown=www-data:www-data public public
COPY --chown=www-data:www-data app app
COPY --chown=www-data:www-data config config
COPY --chown=www-data:www-data database database
COPY --chown=www-data:www-data resources resources
COPY --chown=www-data:www-data routes routes
COPY --chown=www-data:www-data storage storage
COPY --chown=www-data:www-data tests tests

# install php dependencies, and install npm dependencies
RUN composer install --no-dev --no-scripts --no-plugins --ignore-platform-reqs && \
    mkdir -p bootstrap/cache && \
    php artisan key:generate --force
    # npm install && \
    # npm run prod
    # TODO: leaving this here to remind us that we need to rework where the APP_KEY is held
    # rm -f .env && \

CMD ["/bin/sh", "-c", "php-fpm","--daemonize", "--fpm-config", "/usr/local/etc/php-fpm.d/www.conf"]

