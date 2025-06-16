#!/bin/bash
set -e

echo "🚀 Redis Installer"
sudo apt update && sudo apt install -y redis-server
sudo systemctl enable redis && sudo systemctl start redis
echo "✅ Redis installation complete!" 