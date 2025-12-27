#!/bin/bash

# Script to install Node.js.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="Node.js"
APP_COMMAND="node"

install_nodejs() {
    # Install Node.js via NodeSource PPA
    # Verbatim command from official NodeSource documentation
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
