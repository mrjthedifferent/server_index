#!/bin/bash
set -e

echo "🐘 PostgreSQL Installer"
read -rp "📛 Database Name: " DB_NAME
read -rp "🧑 Database Username: " DB_USER
read -rp "🔑 Database Password: " DB_PASS

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo -u postgres psql -c "DO \$\$ BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '$DB_USER') THEN
        CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';
    END IF;
END \$\$;"
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"
echo "✅ PostgreSQL database and user created!" 