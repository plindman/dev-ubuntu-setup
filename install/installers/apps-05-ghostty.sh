#!/bin/bash

# Script to install Ghostty Terminal.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Ghostty"
APP_COMMAND="ghostty"

install_ghostty() {
    # Install Ghostty via official installer script
    # We quiet it to keep logs clean
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)" > /dev/null
}

# Source shared installation helper
