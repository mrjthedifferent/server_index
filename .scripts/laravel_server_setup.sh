#!/bin/bash
set -e

# Laravel Server Setup Master Script

echo "🛠️ Starting Laravel Server Setup (all features)"

read -rp "Install Oh My Zsh? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_ohmyzsh.sh
read -rp "Install Certbot? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_certbot.sh
read -rp "Install Nginx? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_nginx.sh
read -rp "Install Redis? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_redis.sh
read -rp "Install Node.js & npm? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_node.sh
read -rp "Install Supervisor? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_supervisor.sh
read -rp "Install Fail2Ban? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_fail2ban.sh
read -rp "Install PHP? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_php.sh
read -rp "Install MySQL? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_mysql.sh
read -rp "Install PostgreSQL? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_pgsql.sh
read -rp "Install Composer? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/install_composer.sh
read -rp "Setup logrotate for Laravel? (y/n): " ans; [[ $ans =~ ^[Yy]$ ]] && bash features/setup_logrotate.sh

echo "\n✅ All selected Laravel server features installed!"