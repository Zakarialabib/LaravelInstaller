#!/bin/bash

# Install necessary dependencies

sudo apt-get update

if ! command -v apache2 > /dev/null; then
  sudo apt-get install apache2
  echo "Apache2 has been installed."
else
  echo "Apache2 is already installed."
fi

if ! command -v php > /dev/null; then
  sudo apt-get install php
  echo "PHP has been installed."
else
  echo "PHP is already installed."
fi

if ! command -v curl > /dev/null || ! command -v php-cli > /dev/null || ! command -v php-zip > /dev/null || ! command -v unzip > /dev/null; then
  sudo apt install curl php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip unzip -y
  echo "cURL, PHP CLI, PHP ZIP and Unzip have been installed."
else
  echo "cURL, PHP CLI, PHP ZIP and Unzip are already installed."
fi

if ! command -v composer > /dev/null; then
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  echo "Composer has been installed."
  echo '---------------------'
else
  echo "Composer is already installed."
  echo '---------------------'
fi

if ! command -v nvm &> /dev/null
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  mkdir ~/.nvm
  source ~/.zshrc
fi
nvm install 16
nvm alias default 16
echo "Node has been installed."
echo '---------------------'
else
  echo "Node is already installed."
  echo '---------------------'
fi

if ! command -v git > /dev/null; then
sudo apt-get install git
echo "Git has been installed."
echo '---------------------'
else
echo "Git is already installed."
echo '---------------------'
fi

if ! command -v phpmyadmin > /dev/null; then
  sudo apt-get install phpmyadmin
  echo "PHPMyAdmin has been installed."
  echo '---------------------'
else
  echo "PHPMyAdmin is already installed."
  echo '---------------------'
fi

echo "Dependencies have been installed/checked."
echo '---------------------'
