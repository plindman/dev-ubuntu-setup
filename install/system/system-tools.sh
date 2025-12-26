#!/bin/bash

# Script to install System Tools.
# This corresponds to the "System" -> "System Tools" category in SOFTWARE_INDEX.md.

set -e

# Source the helper functions
source "$(dirname "$0")/../../lib/helpers.sh"

print_header "Starting installation of System Tools"

install_and_show_versions htop keychain

print_color "$GREEN" "System Tools installation complete."