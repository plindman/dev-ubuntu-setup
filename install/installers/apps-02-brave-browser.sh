#!/bin/bash

# Script to install Brave Browser.
# Pre-requisites: system-01-core.sh (for gpg), system-02-networking-tools.sh (for curl), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

APP_NAME="Brave Browser"
APP_COMMAND="brave-browser"

install_brave_browser() {
    add_apt_repo "brave-browser" \
        "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg" \
        "https://brave-browser-apt-release.s3.brave.com/ stable main"

    install_and_show_versions brave-browser
}


# Source shared installation helper
