#!/bin/bash

# Script to install Ghostty Terminal.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Ghostty"
APP_COMMAND="ghostty"

install_ghostty() {
    # Install Ghostty via official installer script
    local script
    script=$(download_and_validate_script "https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh") || return 1
    bash "$script" > /dev/null 2>&1
    rm -f "$script"
}

# Source shared installation helper
