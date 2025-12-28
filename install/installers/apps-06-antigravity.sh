#!/bin/bash

# Script to install Google Antigravity (AI-first IDE).
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

APP_NAME="Antigravity"
APP_COMMAND="antigravity"

install_antigravity() {
    # Install Antigravity via official repository method
    # Verbatim commands from official Google Antigravity documentation
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
        sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
    echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
        sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null

    # Update after adding new repository
    sudo apt update
    sudo apt install antigravity -y
}

# Source shared installation helper
