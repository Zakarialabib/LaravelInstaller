#!/bin/bash

# Set up myStockMaster

if [ ! -d "myStockMaster" ]; then

git clone https://github.com/Zakarialabib/myStockMaster.git myStockMaster

cd myStockMaster

composer install
echo "composer packages installed."
npm install
echo "node modules installed."


echo "myStockMaster has been set up."
echo '---------------------'
else
echo "myStockMaster is already set up."
echo '---------------------'
fi
