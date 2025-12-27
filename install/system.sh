#!/bin/bash

# This script orchestrates the installation of all components in the 'system' category.
# The order of execution is important to handle dependencies.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

SCRIPT_DIR="$REPO_ROOT/installers"

print_header "Running System Installation Scripts"

# Update package lists once for all system scripts
print_color "$GREEN" "Updating package lists..."
sudo apt-get -qq update

# The order of execution is important here.
run_script "$SCRIPT_DIR/system-core.sh"
run_script "$SCRIPT_DIR/system-networking-tools.sh"
run_script "$SCRIPT_DIR/system-zsh.sh"
run_script "$SCRIPT_DIR/system-services.sh"
run_script "$SCRIPT_DIR/system-system-tools.sh"
run_script "$SCRIPT_DIR/system-editors.sh"
run_script "$SCRIPT_DIR/system-fonts.sh"
run_script "$SCRIPT_DIR/system-tmux.sh"

print_color "$GREEN" "--- System Installation Complete ---"