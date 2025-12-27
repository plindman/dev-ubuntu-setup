#!/bin/bash

# Script to install Visual Studio Code.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://code.visualstudio.com/docs/setup/linux
# https://itsfoss.gitlab.io/post/how-to-install-vscode-on-ubuntu-2404-2204-or-2004/

APP_NAME="Visual Studio Code"
APP_VERIFY_FUNC="verify_vscode"

install_vscode() {
    # Install VS Code via official repository method
    # Verbatim commands from official VS Code documentation
    sudo apt install software-properties-common -y
    sudo apt-add-repository "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main"

    # Update after adding new repository
    sudo apt update
    sudo apt install code -y
}

# Source shared installation helper
source "$(dirname "$0")/install_app.sh"
