#!/bin/bash

# Script to install build tools.
# This corresponds to the "Development Tools (CLI)" -> "Build Tools" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Tools"

# Install build-essential and ripgrep
install_and_show_versions build-essential ripgrep

print_color "$GREEN" "Tools installation complete."
