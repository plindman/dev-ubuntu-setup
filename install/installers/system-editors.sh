#!/bin/bash

# Script to install all CLI editors: nano, micro, and neovim.
# This corresponds to the "System" -> "Editors" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

print_header "Starting installation of CLI Editors"

install_and_show_versions nano micro neovim

print_color "$GREEN" "CLI Editors installation complete."