#!/bin/bash

# Complete Laravel installation

cd myStockMaster
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
php artisan key:generate
php artisan storage:link
php artisan migrate
cp .env.example .env

echo "Laravel installation has been completed."

