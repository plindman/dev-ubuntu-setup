#!/bin/bash

# Script to install Vivaldi Browser.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

APP_NAME="Vivaldi"
APP_VERIFY_FUNC="verify_vivaldi"

install_vivaldi() {
    # Install dependencies
    # Verbatim commands from official Vivaldi documentation
    install_and_show_versions software-properties-common apt-transport-https curl

    curl -fSsL https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list

    # Update after adding new repository
    sudo apt update
    sudo apt install vivaldi-stable -y
}

# Source shared installation helper
source "$(dirname "$0")/../install_app.sh"
