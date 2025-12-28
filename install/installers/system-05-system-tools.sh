#!/bin/bash

# Script to install System Tools.
# This corresponds to the "System" -> "System Tools" category in SOFTWARE_INDEX.md.

APP_NAME="System Tools"
APP_COMMAND=("htop" "keychain")

install_system_tools() {
    install_and_show_versions htop keychain
}

# Source shared installation helper
