#!/bin/bash

# Script to install Google Chrome.
# Pre-requisites: system-01-core.sh (for gpg), system-02-networking-tools.sh (for wget), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.
# https://itsfoss.gitlab.io/post/how-to-install-google-chrome-on-ubuntu-2404-2204-or-2004/

APP_NAME="Google Chrome"
APP_COMMAND="google-chrome"

install_google_chrome() {
    add_apt_repo "google-chrome" \
        "https://dl.google.com/linux/linux_signing_key.pub" \
        "http://dl.google.com/linux/chrome/deb/ stable main"

    quiet_apt_install google-chrome-stable
}

# Source shared installation helper
