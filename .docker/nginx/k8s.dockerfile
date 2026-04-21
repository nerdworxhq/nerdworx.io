FROM nginx:1.28-alpine3.21

# install openssl
RUN apk update && \
    apk add openssl

#get the nginx conf files into the container
WORKDIR /tmp
COPY --chown=nginx:nginx .docker/nginx/conf .tmp
RUN cp .tmp/nginx.conf /etc/nginx/nginx.conf && \
    mkdir /etc/nginx/sites-available/ && \
    cp .tmp/sites/default.conf /etc/nginx/sites-available/default.conf && \
    rm -rf /tmp/.tmp/

# generate a self signed cert
RUN openssl rand -base64 48 > passphrase.txt && \
    openssl genrsa -aes128 -passout file:passphrase.txt -out server.key 2048 && \
    openssl req -new -passin file:passphrase.txt -key server.key -out server.csr \
      -subj "/C=US/O=cashexpress/OU=Domain Control Validated/CN=*.cashexpressllc.com" && \
    cp server.key server.key.org && \
    openssl rsa -in server.key.org -passin file:passphrase.txt -out server.key && \
    openssl x509 -req -days 36500 -in server.csr -signkey server.key -out server.crt && \
    cat server.crt server.key > ssl.pem && \
    mv ssl.pem /etc/nginx/conf.d/ssl.pem

#make sure the nginx user can get to the all the places it needs
RUN chown -R nginx:nginx /etc/nginx/* && \
    chown -R nginx:nginx /var/log/nginx/*

# replace nginx host and service port variable
ARG PHP_HOST=localhost
RUN sed -i 's/__PHP_HOST/'"$PHP_HOST"'/g' /etc/nginx/sites-available/default.conf
ARG SERVICE_PORT="8443 ssl"
RUN sed -i 's/__SERVICE_PORT/'"$SERVICE_PORT"'/g' /etc/nginx/sites-available/default.conf
RUN sed -i 's/__SKIP_CACHE/0/g' /etc/nginx/sites-available/default.conf

# add the public files
ADD --chown=nginx:nginx ./public /usr/share/nginx/html
USER nginx:nginx
WORKDIR /usr/share/nginx/html
