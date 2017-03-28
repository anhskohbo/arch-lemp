#!/bin/sh

current_dir=`dirname $0`

# Install mariadb
pacman -S mariadb
/usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mysqld && systemctl start mysqld
/usr/bin/mysql_secure_installation

# Install php, nginx
pacman -S nginx php php-cgi php-gd php-mcrypt php-fpm xdebug

cp /etc/php/php.ini /etc/php/php.ini.save
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.save
cp /etc/php/php-fpm.d/www.conf /etc/php/php-fpm.d/www.conf.save

sed -i 's/post_max_size\ =\ 8M/post_max_size\ =\ 128M/g' /etc/php/php.ini
sed -i 's/display_errors\ =\ Off/display_errors\ =\ On/g' /etc/php/php.ini
sed -i 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 100M/g' /etc/php/php.ini
sed -i 's/\;date\.timezone\ =/date\.timezone\ =\ Asia\/Ho_Chi_Minh/g' /etc/php/php.ini

sed -i '/gd.so/s/^;//' /etc/php/php.ini
sed -i '/mcrypt.so/s/^;//' /etc/php/php.ini
sed -i '/mysqli.so/s/^;//' /etc/php/php.ini
sed -i '/pdo_mysql.so/s/^;//' /etc/php/php.ini
sed -i '/iconv.so/s/^;//' /etc/php/php.ini
sed -i '/xdebug.so/s/^;//' /etc/php/conf.d/xdebug.ini

sed -i 's/\#user html;/user vananh;/g' /etc/nginx/nginx.conf
sed -i 's/\user = http/user = vananh/g' /etc/php/php-fpm.d/www.conf
sed -i 's/\group = http/group = vananh/g' /etc/php/php-fpm.d/www.conf
sed -i 's/\listen.owner = http/listen.owner = vananh/g' /etc/php/php-fpm.d/www.conf
sed -i 's/\listen.group = http/listen.group = vananh/g' /etc/php/php-fpm.d/www.conf

# Install and setup phpmyadmin
pacman -S phpmyadmin

# sed -i '/auth_type/s/cookie;/config/' /etc/webapps/phpmyadmin/config.inc.php
# sudo nano /etc/webapps/phpmyadmin/config.inc.php
# $cfg['Servers'][$i]['user'] = 'root';
# $cfg['Servers'][$i]['password'] = 'secret';

phpmyadmin="server {
    listen       80;
    server_name  pma.dev;

    root   /usr/share/webapps/phpMyAdmin;
    index  index.php;

    sendfile off;
    client_max_body_size 128M;

    location ~ \.php\$ {
        try_files      \$uri =404;
        fastcgi_pass   unix:/run/php-fpm/php-fpm.sock;
        fastcgi_index  index.php;
        include        fastcgi.conf;
    }
}";

echo "$phpmyadmin" > "/etc/nginx/pma.conf"
sh $current_dir/hosts-updater.sh pma.dev

# Start nginx & php-fpm
systemctl enable nginx && systemctl start nginx
systemctl enable php-fpm && systemctl start php-fpm

cd /tmp
sh $current_dir/install-dev-tools.sh
