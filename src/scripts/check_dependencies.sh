#!/bin/bash

missing_dependencies=0

check_dependency() {
    local dependency=$1
    if [ "$(uname -s)" = "Darwin" ]; then
        # Check if the package is installed on macOS using Homebrew
        if brew list -1 | grep -q "^$dependency\$"; then
            echo "$dependency is already installed."
        else
            echo "$dependency is not installed."
            missing_dependencies=$((missing_dependencies + 1))
        fi
    elif [ "$(uname -s)" = "Linux" ]; then
        # Check if the package is installed on Linux using apt
        if dpkg -s $dependency > /dev/null 2>&1; then
            echo "$dependency is already installed."
        else
            echo "$dependency is not installed."
            missing_dependencies=$((missing_dependencies + 1))
        fi
    elif [ "$(uname -o)" = "Msys" ]; then
        # Check if the package is installed on Windows using Chocolatey
        if choco list --local-only | grep -q "^$dependency\$"; then
            echo "$dependency is already installed."
        else
            echo "$dependency is not installed."
            missing_dependencies=$((missing_dependencies + 1))
        fi
    else
        echo "Unknown system type. Can't check for $dependency."
    fi
}

check_dependency apache2
check_dependency php
check_dependency composer
check_dependency nvm
check_dependency git
check_dependency phpmyadmin


if [ "$missing_dependencies" -eq 0 ]; then
  echo "All dependencies are installed."
else
  echo "Some dependencies are missing."
fi
