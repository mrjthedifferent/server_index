#!/bin/bash
set -e

echo "🔐 Certbot Installer"
sudo apt update && sudo apt install -y snapd
sudo snap install core && sudo snap refresh core
sudo snap install --classic certbot
sudo ln -sf /snap/bin/certbot /usr/bin/certbot
echo "🕒 Setting auto-renewal for SSL..."
echo "0 3 * * * /usr/bin/certbot renew --quiet" | sudo tee -a /etc/crontab > /dev/null
echo "✅ Certbot installation and auto-renewal setup complete!" 