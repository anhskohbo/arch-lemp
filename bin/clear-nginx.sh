#!/bin/sh

rm -f /etc/nginx/sites/*
systemctl reload nginx php-fpm
