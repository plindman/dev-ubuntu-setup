#!/bin/bash
# Bootstrapper script for dev-ubuntu-setup
# This script is intended to be run via curl:
# curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash

set -e

# Configuration
REPO_URL="${REPO_URL:-https://github.com/plindman/dev-ubuntu-setup.git}"
TARGET_DIR="$HOME/scripts/dev-ubuntu-setup"

print_step() {
    echo -e "\033[1;34m==>\033[0m \033[1m$1\033[0m"
}

# 1. Ensure git is installed
if ! command -v git &> /dev/null; then
    print_step "Git not found. Installing..."
    sudo apt-get update -qq
    sudo apt-get install -y git -qq
fi

# 2. Clone or Update repo
if [ ! -d "$TARGET_DIR" ]; then
    print_step "Cloning repository to $TARGET_DIR..."
    mkdir -p "$(dirname "$TARGET_DIR")"
    git clone "$REPO_URL" "$TARGET_DIR"
else
    print_step "Updating existing repository in $TARGET_DIR..."
    cd "$TARGET_DIR"
    # If it's a local path (for testing), we might not want to pull
    if [[ "$REPO_URL" =~ ^https?:// ]]; then
        git pull
    fi
fi

# 3. Run the actual installer
print_step "Launching installer..."
cd "$TARGET_DIR"
chmod +x bin/install.sh
exec ./bin/install.sh "$@"