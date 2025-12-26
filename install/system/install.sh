#!/bin/bash

# This script orchestrates the installation of all components in the 'system' category.
# The order of execution is important to handle dependencies.

set -e

SCRIPT_DIR=$(dirname "$0")
# Source the helper functions
source "$(dirname "$0")/../../lib/helpers.sh"

# Helper function to run a script if it exists
run_script() {
    local script_path="$1"
    if [ -f "$script_path" ]; then
        # print_header "Executing $(basename "$script_path")"
        bash "$script_path"
        # print_color "$GREEN" "--- Finished $(basename "$script_path") ---"
    else
        print_color "$YELLOW" "Warning: Script not found at $script_path. Skipping."
    fi
}

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