#!/bin/bash

# Script to install Kate.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://kate-editor.org/get-it/

APP_NAME="Kate"
APP_COMMAND="kate"

install_kate() {
    # Install Kate via official repository
    install_and_show_versions kate
}

# Source shared installation helper
