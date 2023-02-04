#!/bin/bash

# Check for necessary dependencies

php -v 

if ! command -v apache2 > /dev/null; then
  echo "Apache2 is not installed."
  missing_dependencies=1
fi

if ! command -v php > /dev/null; then
  echo "PHP is not installed."
  missing_dependencies=1
fi

if ! command -v phpmyadmin > /dev/null; then
  echo "PHPMyAdmin is not installed."
  missing_dependencies=1
fi

if [ -z "$missing_dependencies" ]; then
  echo "All dependencies are installed."
else
  echo "Some dependencies are missing."
fi

