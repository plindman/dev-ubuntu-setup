#!/bin/bash

# Script to install Brave Browser.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

APP_NAME="Brave Browser"
APP_VERIFY_FUNC="verify_brave"

install_brave() {
    # Install Brave via official repository method
    # Verbatim commands from official Brave Browser documentation
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    # Update after adding new repository
    sudo apt update
    sudo apt install brave-browser -y
}

# Source shared installation helper
source "$(dirname "$0")/../install_app.sh"
