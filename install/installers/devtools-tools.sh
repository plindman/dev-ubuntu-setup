#!/bin/bash

# Script to install build tools.
# This corresponds to the "Development Tools (CLI)" -> "Build Tools" category in SOFTWARE_INDEX.md.

APP_NAME="Build Tools"
APP_COMMAND="rg"

install_tools() {
    install_and_show_versions build-essential ripgrep
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
