#!/bin/bash

# Script to install Node.js.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Node.js"

# Install Node.js via NodeSource PPA
# Verbatim command from official NodeSource documentation
sudo apt update
sudo apt install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js installation
if command -v node &> /dev/null; then
    print_color "$GREEN" "Node.js installed successfully. Version: $(node -v)"
else
    print_color "$RED" "Node.js installation failed."
    exit 1
fi

print_color "$GREEN" "Node.js installation complete."
