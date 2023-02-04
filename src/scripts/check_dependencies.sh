#!/bin/bash

missing_dependencies=0

check_dependency() {
  hash "$1" 2>/dev/null || {
    echo "$2 is not installed."
    missing_dependencies=1
  }
}

check_dependency apache2 "Apache2"
check_dependency php "PHP"
check_dependency phpmyadmin "PHPMyAdmin"

if [ "$missing_dependencies" -eq 0 ]; then
  echo "All dependencies are installed."
else
  echo "Some dependencies are missing."
fi
