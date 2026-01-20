#!/bin/bash

# Script to install Google Antigravity (AI-first IDE).
# Pre-requisites: system-00-core.sh (for gpg), system-01-networking.sh (for curl), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Antigravity"
APP_COMMAND="antigravity"

install_antigravity() {
    add_apt_repo "antigravity" \
        "https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg" \
        "https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main"

    quiet_apt_install antigravity
}

# Source shared installation helper
