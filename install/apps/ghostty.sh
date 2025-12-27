#!/bin/bash

# Script to install Ghostty Terminal.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"
source "$REPO_ROOT/install/apps/verify.sh"

print_header "Starting installation of Ghostty Terminal"

# Check if already installed
if verify_ghostty; then
    print_color "$GREEN" "Ghostty is already installed. Skipping."
else
    # Install Ghostty via official installer script
    # Verbatim command from official Ghostty Ubuntu installation guide
    # https://github.com/mkasberg/ghostty-ubuntu
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

    # Verify installation
    if verify_ghostty; then
        print_color "$GREEN" "Ghostty installation complete."
    else
        print_color "$RED" "Ghostty installation failed."
        exit 1
    fi
fi
