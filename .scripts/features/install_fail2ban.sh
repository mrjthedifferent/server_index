#!/bin/bash
set -e

echo "🛠️ Starting Fail2Ban installation..."
echo "Fail2Ban is a security tool that protects your server from brute-force attacks and malicious behavior, especially on services like SSH, Nginx, and web apps."
sudo apt update && sudo apt install -y fail2ban
sudo systemctl enable fail2ban && sudo systemctl start fail2ban

echo "✅ Fail2Ban installation complete!" 