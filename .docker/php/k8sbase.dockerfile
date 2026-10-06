FROM php:8.5.1-fpm-alpine3.23

# copy the setup scripts
WORKDIR /tmp
COPY --chmod=755 .docker/php/scripts .tmp
RUN rm -rf /home/www-data/startups && mv /tmp/.tmp/startups/ /home/www-data/

# setup the os and php environments and clean up the setup scripts
RUN /tmp/.tmp/php-apk.sh \
  && /tmp/.tmp/php-pie.sh \
  && /tmp/.tmp/php-ext.sh \
  && /tmp/.tmp/php-conf.sh \
  && /tmp/.tmp/php-fpm-conf.sh \
  && /tmp/.tmp/php-fpm-opcache.sh \
  && /tmp/.tmp/php-composer.sh \
  && /tmp/.tmp/php-ldaps.sh \
  && rm -rf /tmp/.tmp/

# set permissions on the php folders to make sure the operating user can get to all the places
RUN chown -R www-data:www-data /usr/local/etc/php-fpm.d/* && \
    chown -R www-data:www-data /usr/local/etc/php/* && \
    chown -R www-data:www-data /home/www-data/* && \
    touch /usr/local/var/log/php-fpm.log && \
    chown www-data:www-data /usr/local/var/log/php-fpm.log