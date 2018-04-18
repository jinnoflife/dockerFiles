FROM riconet/shopware:latest

WORKDIR /var/www/html

RUN extDir="$(php-config --extension-dir)" \
    && mkdir -p "${extDir}" \
    && pecl install -o -f xdebug > /dev/null \
    && rm -rf /tmp/pear \
    && echo "zend_extension= '${extDir}/xdebug.so'" > /usr/local/etc/php/conf.d/xdebug.ini

EXPOSE 80
EXPOSE 443
EXPOSE 9000
