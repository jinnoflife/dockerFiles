FROM php:7.2-apache

WORKDIR /var/www/html

ADD https://getcomposer.org/installer /tmp/composer-setup.php

#apt
RUN apt-get -qq update \
  && apt-get -qq upgrade -y \
  && apt-get -qq install -y apt-utils zip wget git \
    libfreetype6 libfreetype6-dev \
    libsqlite3-dev libxml2-dev libicu-dev \
    libmcrypt-dev libjpeg62-turbo-dev \
    libcurl4-gnutls-dev libbz2-dev libssl-dev\
    mcrypt libmagickwand-dev imagemagick \
    libpcre3 > /dev/null \
#right specific things
  && usermod -aG root www-data \
#php
  && docker-php-ext-install opcache phar mysqli pdo pdo_mysql gd zip \
    soap json xml bcmath opcache > /dev/null \
  && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
  && pecl install apcu-5.1.17 \
  && docker-php-ext-enable apcu && a2enmod rewrite \
  && extDir="$(php-config --extension-dir)" \
  && mkdir -p "${extDir}" \
#redis
  && pecl install -o -f redis > /dev/null \
  && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
# php config
  && ln -s /var/www/html /webroot \
  && echo "file_uploads = On\n" \
    "memory_limit = 256M\n" \
    "upload_max_filesize = 15M\n" \
    "post_max_size = 15M\n" \
    "max_execution_time = 120\n" \
    "log_errors = On\n" \
    "error_reporting = E_ALL\n"\
    "error_log = /dev/stderr\n" \
    > /usr/local/etc/php/conf.d/custom.ini \
#apache
  && echo "ServerName myserver.mydomain.com" >> /etc/apache2/apache2.conf \
#composer
  && php /tmp/composer-setup.php --install-dir=/var/www/html/ --filename=composer \
  && php /var/www/html/composer global require hirak/prestissimo \
# install shopware
  && php /var/www/html/composer create-project shopware/composer-project composer-project --no-interaction --stability=dev --no-scripts --remove-vcs --ignore-platform-reqs --no-progress \
  && mv composer-project/* . && mv composer-project/.htaccess . && rm -rf composer-project\
  && chown www-data:www-data ./* -R \
# cleanup
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /var/www/html

EXPOSE 80
EXPOSE 443