#update the apk repos
apk update

#grab the dependencies needed by php apps
apk add mysql-client \
        openssh-client \
        unzip \
        zlib-dev \
        libzip-dev \
        icu-dev \
        openldap-dev \
        git \
        procps \
        libmcrypt-dev \
        libmcrypt \
        libltdl \
        libpng-dev \
        fuse \
        go \
        ca-certificates \
        syslog-ng \
        $PHPIZE_DEPS #comes from the php:7.x-fpm-alpine image
