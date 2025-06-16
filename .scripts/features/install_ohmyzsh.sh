#!/bin/bash
set -e

echo "💅 Oh My Zsh Installer"
sudo apt update && sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "alias art='php artisan'" >> ~/.zshrc
echo "alias ..='cd ..'" >> ~/.zshrc
chsh -s $(which zsh)
echo "✅ Oh My Zsh installation and alias setup complete!" 