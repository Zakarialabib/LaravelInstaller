#!/bin/bash

# Complete Laravel installation

cd project_name
php artisan key:generate
php artisan storage:link
php artisan migrate

echo "Laravel installation has been completed."

