FROM riconet/typo3:8

ENV webPath /var/www/html
WORKDIR  ${webPath}

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && ln -s /var/www/html /webroot \
    && extDir="$(php-config --extension-dir)" \
    && mkdir -p "${extDir}" \
    && echo "zend_extension = '${extDir}/xdebug.so'\n" \
        "xdebug.max_nesting_level=400\n" \
        "max_input_vars=1500\n" \
    > /usr/local/etc/php/conf.d/xdebug.ini

VOLUME ${webPath}

EXPOSE 80
EXPOSE 443
EXPOSE 9000
