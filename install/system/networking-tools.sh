#!/bin/bash

# Script to install Networking Tools.
# This corresponds to the "System" -> "Networking Tools" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Networking Tools"

install_and_show_versions curl wget

print_color "$GREEN" "Networking Tools installation complete."