#!/bin/bash

# Script to install core system utilities.
# This corresponds to the "System" -> "Core" category in SOFTWARE_INDEX.md.

APP_NAME="Core System Utilities"
# No APP_COMMAND - multi-package installer

install_core() {
    # Upgrade system packages
    print_color "$GREEN" "Disabling Ubuntu Pro promotional messages..."
    sudo pro disable esm-apps > /dev/null 2>&1 || true
    sudo pro disable esm-infra > /dev/null 2>&1 || true
    sudo pro disable livepatch > /dev/null 2>&1 || true
    sudo pro disable uc > /dev/null 2>&1 || true

    sudo apt-get -qq upgrade -y

    # Install essential core packages
    install_and_show_versions apt-transport-https ca-certificates gnupg lsb-release unzip
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
