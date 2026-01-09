#!/bin/bash

# Script to install Visual Studio Code.
# Pre-requisites: system-01-core.sh (for gpg), system-02-networking-tools.sh (for wget), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://code.visualstudio.com/docs/setup/linux
# https://itsfoss.gitlab.io/post/how-to-install-vscode-on-ubuntu-2404-2204-or-2004/

APP_NAME="Visual Studio Code"
APP_COMMAND="code"

install_code() {
    add_apt_repo "vscode" \
        "https://packages.microsoft.com/keys/microsoft.asc" \
        "https://packages.microsoft.com/repos/code stable main"

    quiet_apt_install code
}

# Source shared installation helper
