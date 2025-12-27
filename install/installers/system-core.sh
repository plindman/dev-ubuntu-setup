#!/bin/bash

# Script to install core system utilities.
# This corresponds to the "System" -> "Core" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Core System Utilities"

# 1. Upgrade system packages
# System upgrade is not a package installation, using apt-get directly
print_color "$GREEN" "Upgrading system packages..."
# Disable Ubuntu Pro promotional messages
print_color "$GREEN" "Disabling Ubuntu Pro promotional messages..."
sudo pro disable esm-apps > /dev/null 2>&1 || true
sudo pro disable esm-infra > /dev/null 2>&1 || true
sudo pro disable livepatch > /dev/null 2>&1 || true
sudo pro disable uc > /dev/null 2>&1 || true

sudo apt-get -qq upgrade -y

# 2. Install essential core packages
install_and_show_versions apt-transport-https ca-certificates gnupg lsb-release unzip

print_color "$GREEN" "Core System Utilities installation complete."