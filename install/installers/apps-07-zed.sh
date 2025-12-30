#!/bin/bash

# Script to install Zed Editor.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://zed.dev/docs/installation

APP_NAME="Zed Editor"
APP_COMMAND="zed"

install_zed() {
    # Install Zed via official script
    curl -f https://zed.dev/install.sh | sh
}

# Source shared installation helper
