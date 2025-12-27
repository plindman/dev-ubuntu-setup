#!/bin/bash

# Script to install Google Chrome.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.
# https://itsfoss.gitlab.io/post/how-to-install-google-chrome-on-ubuntu-2404-2204-or-2004/

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"
source "$REPO_ROOT/install/apps/verify.sh"

print_header "Starting installation of Google Chrome"

# Check if already installed
if verify_chrome; then
    print_color "$GREEN" "Google Chrome is already installed. Skipping."
else
    # Install Chrome via official repository method
    # Verbatim commands from official Google Chrome installation guide
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

    # Update after adding new repository
    sudo apt update
    sudo apt install google-chrome-stable -y

    # Verify installation
    if verify_chrome; then
        print_color "$GREEN" "Google Chrome installation complete."
    else
        print_color "$RED" "Google Chrome installation failed."
        exit 1
    fi
fi
