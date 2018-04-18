FROM debian:jessie

RUN ln -s /var/www/html /webroot \
    && apt-get -qq update w&& apt-get -qq install -y \
    && wget git unzip\
    && mkdir -p /wpTools


EXPOSE 4881
