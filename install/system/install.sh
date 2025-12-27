#!/bin/bash

# This script orchestrates the installation of all components in the 'system' category.
# The order of execution is important to handle dependencies.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

SCRIPT_DIR="$REPO_ROOT/install/system"

print_header "Running System Installation Scripts"

# Update package lists once for all system scripts
print_color "$GREEN" "Updating package lists..."
sudo apt-get -qq update

# The order of execution is important here.
run_script "$SCRIPT_DIR/core.sh"
run_script "$SCRIPT_DIR/networking-tools.sh"
run_script "$SCRIPT_DIR/services.sh"
run_script "$SCRIPT_DIR/system-tools.sh"
run_script "$SCRIPT_DIR/editors.sh"
run_script "$SCRIPT_DIR/fonts.sh"
run_script "$SCRIPT_DIR/zsh.sh"
run_script "$SCRIPT_DIR/tmux.sh"

print_color "$GREEN" "--- System Installation Complete ---"