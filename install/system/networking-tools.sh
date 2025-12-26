#!/bin/bash

# Script to install Networking Tools.
# This corresponds to the "System" -> "Networking Tools" category in SOFTWARE_INDEX.md.

set -e

# Source the helper functions
source "$(dirname "$0")/../../lib/helpers.sh"

print_header "Starting installation of Networking Tools"

install_and_show_versions curl wget

print_color "$GREEN" "Networking Tools installation complete."