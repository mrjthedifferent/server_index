#!/bin/bash
set -e

echo "📦 Composer Installer"
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(sha384sum composer-setup.php | cut -d ' ' -f 1)"
if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
  echo "❌ Invalid Composer checksum"
  rm composer-setup.php
  exit 1
fi
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
echo "✅ Composer installation complete!" 