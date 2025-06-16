#!/bin/bash
set -e

echo "🐘 PHP Installer"
read -rp "  ➤ Enter PHP version (default: 8.3): " PHP_VERSION
PHP_VERSION=${PHP_VERSION:-8.3}

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common curl wget gnupg2 unzip git ufw lsb-release ca-certificates

echo "🐘 Installing PHP $PHP_VERSION..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php$PHP_VERSION php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-mysql \
php$PHP_VERSION-pgsql php$PHP_VERSION-mbstring php$PHP_VERSION-xml php$PHP_VERSION-bcmath \
php$PHP_VERSION-curl php$PHP_VERSION-zip php$PHP_VERSION-gd php$PHP_VERSION-soap php$PHP_VERSION-readline \
php$PHP_VERSION-redis

echo "⚙️ Tuning PHP settings..."
PHP_INI="/etc/php/$PHP_VERSION/fpm/php.ini"
sudo sed -i 's/^memory_limit = .*/memory_limit = 512M/' $PHP_INI
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 100M/' $PHP_INI
sudo sed -i 's/^post_max_size = .*/post_max_size = 100M/' $PHP_INI
sudo sed -i 's/^max_execution_time = .*/max_execution_time = 300/' $PHP_INI
sudo sed -i 's/^max_input_time = .*/max_input_time = 300/' $PHP_INI
sudo systemctl restart php$PHP_VERSION-fpm

echo "✅ PHP $PHP_VERSION installation complete!" 