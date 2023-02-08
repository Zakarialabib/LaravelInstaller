#!/bin/bash
Check the system type

system_type=$(uname -s)
Install necessary dependencies

if [ "$system_type" = "Linux" ]; then
sudo apt-get update
fi

set -e

if [ "$system_type" = "Linux" ] || [ "$system_type" = "MINGW64_NT-10.0" ]; then
if ! dpkg -s apache2 > /dev/null 2>&1; then
sudo apt-get update
sudo apt-get install apache2
echo "Apache2 has been installed."
echo '---------------------'
else
echo "Apache2 is already installed."
echo '---------------------'
fi

if ! dpkg -s php > /dev/null 2>&1; then
sudo apt-get update
sudo apt-get install php
echo "PHP has been installed."
echo '---------------------'
else
echo "PHP is already installed."
echo '---------------------'
fi

if ! dpkg -s curl > /dev/null || ! dpkg -s php-cli > /dev/null || ! dpkg -s php-zip > /dev/null || ! dpkg -s unzip > /dev/null; then
sudo apt install curl php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip unzip -y
echo "cURL, PHP CLI, PHP ZIP and Unzip have been installed."
echo '---------------------'
else
echo "cURL, PHP CLI, PHP ZIP and Unzip are already installed."
echo '---------------------'
fi

if ! dpkg -s composer > /dev/null; then
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo "Composer has been installed."
echo '---------------------'
else
echo "Composer is already installed."
echo '---------------------'
fi

if ! dpkg -s nvm &> /dev/null
then
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
mkdir ~/.nvm
source ~/.zshrc
nvm install 16
nvm alias default 16
echo "Node has been installed."
echo '---------------------'
else
echo "Node is already installed."
echo '---------------------'
fi

if ! dpkg -s git > /dev/null; then
sudo apt-get install git
echo "Git has been installed."
echo '---------------------'
else
echo "Git is already installed."
echo '---------------------'
fi

if ! dpkg -s phpmyadmin > /dev/null; then
sudo apt-get install phpmyadmin
echo "PHPMyAdmin has been installed."
echo '---------------------'
else
echo "PHPMyAdmin is already installed."
echo '---------------------'
fi
elif [ "$system_type" = "Darwin" ]; then
  echo "Dependencies for macOS system will be installed here."
  echo '---------------------'
  if ! command -v apachectl > /dev/null; then
    brew install apache2
    echo "Apache2 has been installed."
    echo '---------------------'
  else
    echo "Apache2 is already installed."
    echo '---------------------'
  fi
  if ! command -v php > /dev/null; then
    brew install php
    echo "PHP has been installed."
    echo '---------------------'
  else
    echo "PHP is already installed."
    echo '---------------------'
  fi
  if ! command -v curl > /dev/null || ! command -v php > /dev/null || ! command -v unzip > /dev/null; then
    brew install curl php@8.2 unzip
    echo "cURL, PHP, and Unzip have been installed."
    echo '---------------------'
  else
    echo "cURL, PHP, and Unzip are already installed."
    echo '---------------------'
  fi
  if ! command -v composer > /dev/null; then
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    echo "Composer has been installed."
    echo '---------------------'
  else
    echo "Composer is already installed."
    echo '---------------------'
  fi
  if ! command -v nvm > /dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.bash_profile
    nvm install 16
    nvm alias default 16
    echo "Node has been installed."
  else
    echo "Node is already installed."
  fi
  if ! command -v git > /dev/null; then
    brew install git
    echo "Git has been installed."
  else
    echo "Git is already installed."
  fi
  if ! command -v phpmyadmin > /dev/null; then
    echo "PHPMyAdmin can't be installed directly on macOS, you have to install it manually."
  else
    echo "PHPMyAdmin is already installed."
  fi
  
  echo "Dependencies have been installed/checked."
