#!/bin/bash
set -e

echo "🐘 PostgreSQL Installer"

read -rsp "🔑 Enter new PostgreSQL root (postgres) user password: " ROOT_PASS

echo "\n🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y postgresql postgresql-contrib
sudo systemctl start postgresql

echo "$ROOT_PASS" | sudo -S -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$ROOT_PASS';"

echo "✅ PostgreSQL installed, started, and root password set!" 