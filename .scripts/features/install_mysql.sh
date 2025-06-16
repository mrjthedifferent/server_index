#!/bin/bash
set -e

echo "🗄️ MySQL Installer"
read -rp "📛 Database Name: " DB_NAME
read -rp "🧑 Database Username: " DB_USER
read -rp "🔑 Database Password: " DB_PASS

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
echo "✅ MySQL database and user created!" 