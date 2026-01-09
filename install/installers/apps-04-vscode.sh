#!/bin/bash

# Script to install Visual Studio Code.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://code.visualstudio.com/docs/setup/linux
# https://itsfoss.gitlab.io/post/how-to-install-vscode-on-ubuntu-2404-2204-or-2004/

APP_NAME="Visual Studio Code"
APP_COMMAND="code"

install_code() {
    # Install VS Code via official repository method
    # Verbatim commands from official VS Code documentation

    # sudo apt install software-properties-common -y
    # sudo apt-add-repository "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main"

    # Check if key exists to avoid duplicate logic or errors
    if [ ! -f /usr/share/keyrings/packages.microsoft.gpg ]; then
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
    fi
    echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    # Update after adding new repository
    sudo apt-get -qq update
    install_and_show_versions code
}

# Source shared installation helper
