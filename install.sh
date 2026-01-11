#!/bin/bash
# install.sh - Refactored with separate functions

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

exec > >(tee "$LOG_FILE") 2>&1

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

# Worker functions
prepare_environment() {
    install_package "git"
}

clone_repository() {
    print_step "Cloning repository to $TARGET_DIR..."
    git clone -q "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR"
}

execute_installation() {
    print_step "Launching installer..."
    chmod +x bin/install.sh
    ./bin/install.sh "$@"
}

verify_installation() {
    print_step "Verifying installation..."
    chmod +x bin/verify.sh
    ./bin/verify.sh
}

# Main run function
run() {
    prepare_environment
    clone_repository
    execute_installation "$@"
    verify_installation
}

# Execute if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run "$@"
fi