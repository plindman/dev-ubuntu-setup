#!/bin/bash

# Script to install Zed Editor.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://zed.dev/docs/installation

APP_NAME="Zed Editor"
APP_COMMAND="zed"

install_zed() {
    # Install Zed via official script
    local script
    script=$(download_and_validate_script "https://zed.dev/install.sh") || return 1
    bash "$script" > /dev/null 2>&1
    rm -f "$script"
}

# Source shared installation helper
