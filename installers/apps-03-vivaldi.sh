#!/bin/bash

# Script to install Vivaldi Browser.
# Pre-requisites: system-00-core.sh (for gpg), system-01-networking.sh (for curl), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

APP_NAME="Vivaldi"
APP_COMMAND="vivaldi-stable"

install_vivaldi_stable() {
    add_apt_repo "vivaldi" \
        "https://repo.vivaldi.com/archive/linux_signing_key.pub" \
        "https://repo.vivaldi.com/archive/deb/ stable main"

    quiet_apt_install vivaldi-stable
}

# Source shared installation helper
