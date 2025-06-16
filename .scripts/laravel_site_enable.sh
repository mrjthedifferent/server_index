#!/bin/bash
set -e

echo "🛠️ Laravel Domain & Queue Setup Script"

read -rp "📂 Enter full Laravel project path (e.g., /var/www/my-app): " LARAVEL_PATH
read -rp "🌐 Enter domain name (e.g., example.com): " DOMAIN_NAME
read -rp "🐘 Enter PHP version (default: 8.3): " PHP_VERSION
PHP_VERSION=${PHP_VERSION:-8.3}

NGINX_CONF="/etc/nginx/sites-available/$DOMAIN_NAME"
SUPERVISOR_CONF="/etc/supervisor/conf.d/${DOMAIN_NAME//./_}_queue.conf"
LOG_DIR="/var/log/laravel/$DOMAIN_NAME"

# Check Laravel public path
if [ ! -d "$LARAVEL_PATH/public" ]; then
  echo "❌ ERROR: '$LARAVEL_PATH/public' does not exist."
  exit 1
fi

# Ask if supervisor should be used
SUPERVISOR_AVAILABLE=false
if command -v supervisorctl &> /dev/null; then
  SUPERVISOR_AVAILABLE=true
else
  echo "⚠️ Supervisor is not installed."
  read -rp "Do you want to install Supervisor and configure queue worker? (y/n): " INSTALL_SUP
  if [[ "$INSTALL_SUP" =~ ^[Yy]$ ]]; then
    sudo apt update
    sudo apt install -y supervisor
    sudo systemctl enable supervisor
    sudo systemctl start supervisor
    SUPERVISOR_AVAILABLE=true
  else
    echo "ℹ️ Proceeding without Supervisor queue configuration."
  fi
fi

# Create Nginx config
echo "📄 Creating Nginx config for $DOMAIN_NAME..."

sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN_NAME;
    root $LARAVEL_PATH/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ ^/index\.php(/|$) {
        fastcgi_pass unix:/var/run/php/php$PHP_VERSION-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_hide_header X-Powered-By;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

# Enable Nginx site
echo "🔗 Enabling Nginx site..."
sudo ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/$DOMAIN_NAME
sudo nginx -t && sudo systemctl reload nginx

# Create Laravel log dir
sudo mkdir -p "$LOG_DIR"
sudo chown -R www-data:www-data "$LOG_DIR"

# Optional: Create Supervisor config
if [ "$SUPERVISOR_AVAILABLE" = true ]; then
  echo "🧩 Creating Supervisor config for queue worker..."

  sudo tee "$SUPERVISOR_CONF" > /dev/null <<EOF
[program:${DOMAIN_NAME//./_}_queue]
process_name=%(program_name)s_%(process_num)02d
command=php $LARAVEL_PATH/artisan queue:work --sleep=3 --tries=3 --timeout=90
autostart=true
autorestart=true
user=www-data
numprocs=1
redirect_stderr=true
stdout_logfile=$LOG_DIR/queue.log
stopwaitsecs=3600
EOF

  # Reload Supervisor
  echo "🔄 Reloading Supervisor config..."
  sudo supervisorctl reread
  sudo supervisorctl update
  sudo supervisorctl start "${DOMAIN_NAME//./_}_queue:"
fi

echo ""
echo "✅ Laravel site '$DOMAIN_NAME' is configured."
if [ "$SUPERVISOR_AVAILABLE" = true ]; then
  echo "🔁 Queue worker registered under Supervisor."
else
  echo "ℹ️ Queue worker NOT configured (Supervisor not installed or declined)."
fi
