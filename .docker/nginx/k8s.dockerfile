FROM nginx:1.29.8-alpine3.23

# install necessary tools
RUN apk update && apk add --no-cache bash

# get the nginx conf files into the container
WORKDIR /tmp
COPY --chown=nginx:nginx .docker/nginx/conf .tmp
RUN cp .tmp/nginx.conf /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/sites-available/ && \
    cp .tmp/sites/default.conf /etc/nginx/sites-available/default.conf && \
    rm -rf /tmp/.tmp/

# make sure nginx user has proper permissions
RUN chown -R nginx:nginx /etc/nginx/* && \
    chown -R nginx:nginx /var/log/nginx/*

# replace nginx host and service port variables
ARG PHP_HOST=localhost
RUN sed -i 's/__PHP_HOST/'"$PHP_HOST"'/g' /etc/nginx/sites-available/default.conf
ARG SERVICE_PORT="80"
RUN sed -i 's/__SERVICE_PORT/'"$SERVICE_PORT"'/g' /etc/nginx/sites-available/default.conf
RUN sed -i 's/__SKIP_CACHE/0/g' /etc/nginx/sites-available/default.conf

# add the public files
ADD --chown=nginx:nginx ./public /usr/share/nginx/html

# run as root so Nginx can bind to port 80
USER root
WORKDIR /usr/share/nginx/html