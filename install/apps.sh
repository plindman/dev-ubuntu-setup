#!/bin/bash

# This script orchestrates the installation of all components in the 'apps' category.
# These are GUI applications that should only be installed on a workstation with a display.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

SCRIPT_DIR="$REPO_ROOT/installers"

print_header "Running GUI Applications Installation Scripts"

# Update package lists once for all apps scripts
sudo apt-get -qq update

# The order of execution is important here.
run_script "$SCRIPT_DIR/apps-chrome.sh"
run_script "$SCRIPT_DIR/apps-brave-browser.sh"
run_script "$SCRIPT_DIR/apps-vivaldi.sh"
run_script "$SCRIPT_DIR/apps-vscode.sh"
run_script "$SCRIPT_DIR/apps-ghostty.sh"
run_script "$SCRIPT_DIR/apps-antigravity.sh"

print_color "$GREEN" "--- GUI Applications Installation Complete ---"
