#!/bin/bash

# Script to install Brave Browser.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"
source "$REPO_ROOT/install/apps/verify.sh"

print_header "Starting installation of Brave Browser"

# Check if already installed
if verify_brave; then
    print_color "$GREEN" "Brave Browser is already installed. Skipping."
else
    # Install Brave via official repository method
    # Verbatim commands from official Brave Browser documentation
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    # Update after adding new repository
    sudo apt update
    sudo apt install brave-browser -y

    # Verify installation
    if verify_brave; then
        print_color "$GREEN" "Brave Browser installation complete."
    else
        print_color "$RED" "Brave Browser installation failed."
        exit 1
    fi
fi
