#!/bin/bash

# Script to install Ghostty Terminal.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Ghostty"
APP_VERIFY_FUNC="verify_ghostty"

install_ghostty() {
    # Install Ghostty via official installer script
    # Verbatim command from official Ghostty Ubuntu installation guide
    # https://github.com/mkasberg/ghostty-ubuntu
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
}

# Source shared installation helper
source "$(dirname "$0")/install_app.sh"
