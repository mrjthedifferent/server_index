#!/bin/bash
set -e

echo "��️ MySQL Installer"

read -rsp "🔑 Enter new MySQL root user password: " ROOT_PASS

echo "\n🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y mysql-server
sudo systemctl start mysql

# Set root password
sudo mysql -u root <<MYSQL_SCRIPT
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$ROOT_PASS';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "✅ MySQL installed, started, and root password set!" 