#!/bin/bash
set -e

echo "🟢 Node.js & npm Installer"
sudo apt update && sudo apt install -y curl
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node -v && npm -v
echo "✅ Node.js and npm installation complete!" 