#!/bin/bash
# Bootstrapper script for dev-ubuntu-setup
# This script is intended to be run via curl:
# curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash

set -e

# Configuration

REPO_URL="${REPO_URL:-https://github.com/plindman/dev-ubuntu-setup.git}"

TARGET_DIR=$(mktemp -d -t dev-setup-XXXXXXXXXX)



# Ensure cleanup on exit if successful

cleanup() {

    local exit_code=$?

    if [ $exit_code -eq 0 ]; then

        echo -e "\033[1;34m==>\033[0m \033[1mCleaning up temporary files...\033[0m"

        rm -rf "$TARGET_DIR"

    else

        echo -e "\033[1;33m==>\033[0m \033[1mInstallation failed. Keeping repository at $TARGET_DIR for inspection.\033[0m"

    fi

}

trap cleanup EXIT



print_step() {

    echo -e "\033[1;34m==>\033[0m \033[1m
\033[0m"

}



command_exists() {

    type "
" &> /dev/null

}



install_package() {

    local pkg=


    if ! command_exists "$pkg"; then

        print_step "$pkg not found. Installing..."

        sudo apt-get -qq update > /dev/null

        sudo apt-get install -y "$pkg" -qq

    fi

}



# 1. Ensure git is installed

install_package "git"



# 2. Clone repo

print_step "Cloning repository to $TARGET_DIR..."

git clone "$REPO_URL" "$TARGET_DIR"



# 3. Run the actual installer

print_step "Launching installer..."

cd "$TARGET_DIR"

chmod +x bin/install.sh

./bin/install.sh "$@"
