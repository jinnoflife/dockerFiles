FROM php:7.0-apache

WORKDIR /var/www/html

ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /ioncube/
#ADD https://raw.githubusercontent.com/neta-io/shopware-docker/master/conf/php.dev.ini /usr/local/etc/php/php.ini
#apt
RUN apt-get -qq update \
    && apt-get -qq install -y apt-utils zip wget git \
        libfreetype6 libfreetype6-dev \
        libsqlite3-dev libxml2-dev libicu-dev \
        libmcrypt-dev libjpeg62-turbo-dev \
        libpng12-dev libcurl4-gnutls-dev libbz2-dev libssl-dev\
        mcrypt libmagickwand-6.q16-2 libmagickwand-dev imagemagick \
        libpcre3 > /dev/null \
#php
    && docker-php-ext-install opcache phar mysqli pdo pdo_mysql gd zip bz2 mcrypt \
        soap json xml bcmath opcache > /dev/null \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && pecl install apcu-5.1.5 \
    && docker-php-ext-enable apcu && a2enmod rewrite \
    && extDir="$(php-config --extension-dir)" \
    && mkdir -p "${extDir}" \
#redis    
    && pecl install -o -f redis > /dev/null \
    && rm -rf /tmp/pear \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
#ioncube
    && tar zxf /ioncube/ioncube_loaders_lin_x86-64.tar.gz -C /ioncube/\
    && cp /ioncube/ioncube/ioncube_loader_lin_7.0.so "${extDir}" \
    && rm -rf /ioncube \
    && echo "zend_extension = '${extDir}/ioncube_loader_lin_7.0.so'" \
    > /usr/local/etc/php/conf.d/_ioncube.ini \
    && ln -s /var/www/html /webroot \
    && echo "file_uploads = On\n" \
         "memory_limit = 256M\n" \
         "upload_max_filesize = 15M\n" \
         "post_max_size = 15M\n" \
         "max_execution_time = 120\n" \
         > /usr/local/etc/php/conf.d/uploads.ini \
# cleanup
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 80
EXPOSE 443
EXPOSE 9000
