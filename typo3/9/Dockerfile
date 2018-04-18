FROM php:7.2-apache

ENV webPath /var/www/html
WORKDIR  ${webPath}


RUN apt-get -qq update && apt-get -qq upgrade -y \
    && apt-get -qq install -y zip wget git \
    libfreetype6 libfreetype6-dev \
    libsqlite3-dev libxml2-dev libicu-dev \
    libjpeg62-turbo-dev libcurl4-gnutls-dev \
    libbz2-dev libssl-dev libpcre3 \
    libmagickwand-dev \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install intl \
    && docker-php-ext-install mysqli pdo_mysql soap \
    zip opcache bcmath bz2 \
     > /dev/null \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && ln -s /var/www/html /webroot \
    && extDir="$(php-config --extension-dir)" \
    && mkdir -p "${extDir}" \
    && echo "extension='${extDir}/imagick.so'" > /usr/local/etc/php/conf.d/imagick.ini \
    && echo "file_uploads = On\n" \
        "memory_limit = 256M\n" \
        "upload_max_filesize = 15M\n" \
        "post_max_size = 15M\n" \
        "max_execution_time = 240\n" \
        "max_input_vars = 1500\n" \
        "always_populate_raw_post_data=-1" \
      > /usr/local/etc/php/conf.d/uploads.ini

VOLUME ${webPath}

EXPOSE 80
EXPOSE 443
EXPOSE 9000
