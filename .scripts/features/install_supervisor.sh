#!/bin/bash
set -e

echo "🔁 Supervisor Installer"
sudo apt update && sudo apt install -y supervisor
sudo systemctl enable supervisor && sudo systemctl start supervisor
echo "✅ Supervisor installation complete!" 