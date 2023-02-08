#!/bin/bash

# Set up myStockMaster

if [ "$(uname)" == "Darwin" ]; then
  # Mac OS X
  echo "Setting up myStockMaster on Mac OS X"
  if [ ! -d "/Library/laravel-installer/Www/myStockMaster" ]; then
    git clone https://github.com/Zakarialabib/myStockMaster.git /Library/laravel-installer/Www/myStockMaster
    cd /Library/laravel-installer/Www/myStockMaster
    composer install
    echo "Composer packages installed."
    npm install
    echo "Node modules installed."
    echo "myStockMaster has been set up on Mac OS X."
  else
    echo "myStockMaster is already set up on Mac OS X."
  fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Linux
  echo "Setting up myStockMaster on Linux"
  if [ ! -d "/var/www/html/myStockMaster" ]; then
    git clone https://github.com/Zakarialabib/myStockMaster.git /var/www/html/myStockMaster
    cd /var/www/html/myStockMaster
    composer install
    echo "Composer packages installed."
    npm install
    echo "Node modules installed."
    echo "myStockMaster has been set up on Linux."
  else
    echo "myStockMaster is already set up on Linux."
  fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  # Windows
  echo "Setting up myStockMaster on Windows"
  if [ ! -d "/c/laravel-installer/www/myStockMaster" ]; then
    git clone https://github.com/Zakarialabib/myStockMaster.git /c/laravel-installer/www/myStockMaster
    cd /c/laravel-installer/www/myStockMaster
    composer install
    echo "Composer packages installed."
    npm install
    echo "Node modules installed."
    echo "myStockMaster has been set up on Windows."
  else
    echo "myStockMaster is already set up on Windows."
  fi
else
  echo "Operating system not supported."
fi
