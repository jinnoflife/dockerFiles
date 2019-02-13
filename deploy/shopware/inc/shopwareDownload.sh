#!/usr/bin/env bash

case "$1" in
    "latest")
        wget http://releases.s3.shopware.com.s3.amazonaws.com/install_5.5.6_9cb9f7b8f22ef979df1acd99b0e8071a6fbaf785.zip\
        -O /var/www/html/sw.zip
    ;;
    "5.5")
            wget http://releases.s3.shopware.com.s3.amazonaws.com/install_5.5.6_9cb9f7b8f22ef979df1acd99b0e8071a6fbaf785.zip\
            -O /var/www/html/sw.zip
        ;;
    "5.4")
            wget http://releases.s3.shopware.com.s3.amazonaws.com/install_5.4.6_f667f6471a77bb5af0c115f3e243594e6353747e.zip\
            -O /var/www/html/sw.zip
        ;;
    "5.3")
            wget http://releases.s3.shopware.com.s3.amazonaws.com/install_5.3.7_741ae9fb77ecb227dc6be9c1028ded1e957c0e14.zip\
            -O /var/www/html/sw.zip
        ;;
    "5.2")
            wget http://releases.s3.shopware.com.s3.amazonaws.com/install_5.2.27_56d5aabc56c2e48d84084d0381a72a3897d5263f.zip\
            -O /var/www/html/sw.zip
        ;;
esac

if [[ -f /var/www/html/sw.zip ]]; then
    cd /var/www/html
    unzip sw.zip -d /var/www/html
    echo "shopware unzipped"
else
    echo "shopware not downloaded"
fi
