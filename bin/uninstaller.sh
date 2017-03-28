#!/bin/sh

systemctl stop nginx php-fpm mysqld
systemctl daemon-reload

pacman -Rs nginx php php-cgi php-gd php-mcrypt php-fpm xdebug phpmyadmin
pacman -Rs mariadb

rm -rf /etc/php
rm -rf /etc/nginx
rm -rf /var/lib/mysql
