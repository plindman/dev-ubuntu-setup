#!/bin/bash

# Script to install Kate.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://kate-editor.org/get-it/

APP_NAME="Kate"
APP_COMMAND="kate"

install_kate() {
    # Install Kate via official repository
    quiet_apt_install kate
}

post_install_info_kate() {
    echo "To enable the Filesystem Browser sidebar (recommended for folder navigation):"
    echo "1. Open Kate."
    echo "2. Go to Settings -> Configure Kate... (or press Ctrl + ,)."
    echo "3. Select 'Plugins' from the left sidebar."
    echo "4. Check the box for 'Filesystem Browser' (under Application plugins)."
    echo "5. Click OK or Apply."
}

# Source shared installation helper
