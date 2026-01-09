#!/bin/bash

# Script to install Google Antigravity (AI-first IDE).
# Pre-requisites: system-01-core.sh (for gpg), system-02-networking-tools.sh (for curl), add_apt_repo helper.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Antigravity"
APP_COMMAND="antigravity"

install_antigravity() {
    add_apt_repo "antigravity" \
        "https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg" \
        "https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main"

    install_and_show_versions antigravity
}

# Source shared installation helper
