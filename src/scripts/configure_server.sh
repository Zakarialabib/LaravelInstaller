#!/bin/bash

# Configure Apache, PHP, and PHPMyAdmin

OS=`uname -s`

if [ "$OS" == "Linux" ]; then
  if apache2 -v | grep "Apache"; then
    echo "Enabling Apache Things"
    sudo a2enmod rewrite
    sudo phpenmod mbstring
    sudo a2enmod ssl
    echo "Opening Ports 80 & 443"
    sudo ufw allow 80
    sudo ufw allow 443
    sudo sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
    sudo service apache2 restart
    echo "Apache has been configured."
    echo '---------------------'
  else
    echo "Apache is not installed."
    echo '---------------------'
  fi

  if php -v | grep "PHP"; then
    echo "PHP is already installed."
    echo '---------------------'
  else
    echo "PHP is not installed."
    echo '---------------------'
  fi

  if dpkg -s phpmyadmin &> /dev/null; then
    echo "PHPMyAdmin is already installed."
    echo '---------------------'
  else
    echo "PHPMyAdmin is not installed."
    echo '---------------------'
  fi

  if mysql -u root -e "use mysql"; then
    echo "MySQL is already installed."
    echo '---------------------'
  else
    echo "MySQL is not installed."
    echo '---------------------'
  fi

  mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"
  echo "MySQL root password has been set."
  echo '---------------------'

elif [ "$OS" == "Darwin" ]; then
  if apachectl -v | grep "Apache"; then
    echo "Enabling Apache Things"
    sudo apachectl start
    echo "Opening Ports 80 & 443"
    sudo apachectl configtest
    echo "Apache has been configured."
    echo '---------------------'
  else
    echo "Apache is not installed."
    echo '---------------------'
  fi

  if php -v | grep "PHP"; then
    echo "PHP is already installed."
    echo '---------------------'
  else
    echo "PHP is not installed."
    echo '---------------------'
  fi

  if mysql -v | grep "MySQL"; then
    echo "MySQL is already installed."
    echo '---------------------'
  else
    echo "MySQL is not installed."
    echo '---------------------'
  fi

  mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"
  echo "MySQL root password has been set."
  echo '---------------------'

else
  echo "Not compatible with the operating system."
  echo '---------------------'
fi

