echo "\e[36mInstall PHP Composer\e[0m"
curl -OL https://getcomposer.org/composer.phar
chmod +x composer.phar
sudo mv --force composer.phar /usr/local/bin/composer

echo "\e[36mInstall WP CLI\e[0m"
curl -OL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv --force wp-cli.phar /usr/local/bin/wp

echo "\e[36mInstall PHPCS\e[0m"
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x phpcs.phar
sudo mv --force phpcs.phar /usr/local/bin/phpcs

echo "\e[36mInstall PHPCBF\e[0m"
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
chmod +x phpcbf.phar
sudo mv --force phpcbf.phar /usr/local/bin/phpcbf

echo "\e[36mInstall PHP-CS-Fixer\e[0m"
curl -OL https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v1.12.1/php-cs-fixer.phar
chmod +x php-cs-fixer.phar
sudo mv --force php-cs-fixer.phar /usr/local/bin/php-cs-fixer

echo "\e[36mInstall PHP Deployer\e[0m"
curl -OL http://deployer.org/deployer.phar
chmod +x deployer.phar
sudo mv --force deployer.phar /usr/local/bin/dep

echo "\e[36mUpdate WPCS\e[0m"
cd ~/.phpcs/wpcs && git pull

echo "\e[32mOK!\e[0m"
