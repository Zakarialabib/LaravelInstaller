#!/bin/bash

# Complete Laravel installation

if [[ "$(uname)" == "Darwin" ]]; then
  cd /Library/laravel-installer/Www/myStockMaster
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  cd /var/www/html/myStockMaster
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
  cd /c/laravel-installer/www/myStockMaster
else
  echo "The operating system is not supported."
  exit 1
fi

sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
php artisan key:generate
php artisan storage:link
php artisan migrate
cp .env.example .env

echo "Laravel installation has been completed."
