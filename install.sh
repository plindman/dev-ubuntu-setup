#!/bin/bash
# Bootstrapper script for dev-ubuntu-setup
# curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash

set -e

# Configuration
export DEBIAN_FRONTEND=noninteractive
REPO_URL="${REPO_URL:-https://github.com/plindman/dev-ubuntu-setup.git}"
UUID=$(cat /proc/sys/kernel/random/uuid 2>/dev/null || date +%s%N)
TARGET_DIR="/tmp/dev-ubuntu-setup-$UUID"
mkdir -p "$TARGET_DIR"

# Logging setup
LOG_DIR="$HOME/.local/state/dev-ubuntu-setup"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/install.log"

# Redirect all output to log file while still showing in terminal (overwrite each run)
exec > >(tee "$LOG_FILE") 2>&1

# Ensure cleanup on exit if successful
cleanup() {
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo -e "\033[1;34m==>\033[0m \033[1mCleaning up temporary files...\033[0m"
        rm -rf "$TARGET_DIR"
        echo -e "\033[1;32m==>\033[0m \033[1mSetup log available at: $LOG_FILE\033[0m"
    else
        echo -e "\033[1;33m==>\033[0m \033[1mInstallation failed. Keeping repository at $TARGET_DIR for inspection.\033[0m"
        echo -e "\033[1;31m==>\033[0m \033[1mCheck the log for details: $LOG_FILE\033[0m"
    fi
}
trap cleanup EXIT SIGINT SIGTERM

print_step() {
    echo -e "\033[1;34m==>\033[0m \033[1m$1\033[0m"
}

command_exists() {
    type "$1" &> /dev/null
}

install_package() {
    local pkg=$1
    if ! command_exists "$pkg"; then
        print_step "$pkg not found. Installing..."
        sudo apt-get -qq update > /dev/null
        sudo apt-get install -y "$pkg" -qq
    fi
}

# 1. Prepare environment
install_package "git"

# 2. Clone repository
print_step "Cloning repository to $TARGET_DIR..."
git clone -q "$REPO_URL" "$TARGET_DIR"
cd "$TARGET_DIR"

# 3. Execute installation
print_step "Launching installer..."
chmod +x bin/install.sh
./bin/install.sh "$@"

# 4. Verify installation
print_step "Verifying installation..."
chmod +x bin/verify.sh
./bin/verify.sh