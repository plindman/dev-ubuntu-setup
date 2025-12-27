#!/bin/bash

# Script to install Vivaldi Browser.
# This corresponds to the "Applications (GUI)" -> "Web Browsers" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"
source "$REPO_ROOT/install/apps/verify.sh"

print_header "Starting installation of Vivaldi Browser"

# Check if already installed
if verify_vivaldi; then
    print_color "$GREEN" "Vivaldi is already installed. Skipping."
else
    # Install dependencies
    # Verbatim commands from official Vivaldi documentation
    install_and_show_versions software-properties-common apt-transport-https curl

    curl -fSsL https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vivaldi.gpg] https://repo.vivaldi.com/archive/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list

    # Update after adding new repository
    sudo apt update
    sudo apt install vivaldi-stable -y

    # Verify installation
    if verify_vivaldi; then
        print_color "$GREEN" "Vivaldi installation complete."
    else
        print_color "$RED" "Vivaldi installation failed."
        exit 1
    fi
fi
