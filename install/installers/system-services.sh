#!/bin/bash

# Script to install system services.
# This corresponds to the "System" -> "System Services" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of System Services"

# 1. Install openssh-server
install_and_show_versions openssh-server

print_color "$GREEN" "System Services installation complete."