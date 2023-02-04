#!/bin/bash

# Configure Apache, PHP, and PHPMyAdmin

sudo a2enmod rewrite
sudo sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
sudo service apache2 restart

echo "Apache, PHP, and PHPMyAdmin have been configured."

