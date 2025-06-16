#!/bin/bash
set -e

echo "🧻 Configuring logrotate for Laravel..."
sudo tee /etc/logrotate.d/laravel > /dev/null <<EOF
/var/www/*/storage/logs/laravel.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF
echo "✅ Logrotate configuration for Laravel complete!" 