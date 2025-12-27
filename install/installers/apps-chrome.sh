#!/bin/bash

# Script to install Google Chrome.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.
# https://itsfoss.gitlab.io/post/how-to-install-google-chrome-on-ubuntu-2404-2204-or-2004/

APP_NAME="Google Chrome"
APP_VERIFY_FUNC="verify_chrome"

install_chrome() {
    # Install Chrome via official repository method
    # Verbatim commands from official Google Chrome installation guide
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

    # Update after adding new repository
    sudo apt update
    sudo apt install google-chrome-stable -y
}

# Source shared installation helper
source "$(dirname "$0")/../install_app.sh"
