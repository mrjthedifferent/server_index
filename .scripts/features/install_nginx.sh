#!/bin/bash
set -e

echo "🌐 Nginx Installer"
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "✅ Nginx installation complete!" 

echo "🧱 UFW Firewall Setup"
sudo apt update && sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable
echo "✅ UFW firewall setup complete!" 