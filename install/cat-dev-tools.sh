#!/bin/bash

# This script orchestrates the installation of all components in the 'dev-tools' category.
# The order of execution is important to handle dependencies.

set -e

# Set repository root
if [[ -z "${REPO_ROOT:-}" ]]; then
    REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Source the helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

SCRIPT_DIR="$REPO_ROOT/installers"

install_dev_tools() {
    print_header "Running Development Tools (CLI) Installation Scripts"

    # Update package lists once for all dev-tools scripts
    print_color "$GREEN" "Updating package lists..."
    sudo apt-get -qq update

    # The order of execution is important here.
    run_script "$SCRIPT_DIR/devtools-tools.sh"
    run_script "$SCRIPT_DIR/devtools-git.sh"
    run_script "$SCRIPT_DIR/devtools-gh.sh"
    run_script "$SCRIPT_DIR/devtools-nodejs.sh"
    run_script "$SCRIPT_DIR/devtools-bun.sh"
    run_script "$SCRIPT_DIR/devtools-uv.sh"
    run_script "$SCRIPT_DIR/devtools-gemini-cli.sh"
    run_script "$SCRIPT_DIR/devtools-claude-code.sh"
    run_script "$SCRIPT_DIR/devtools-services.sh"

    print_color "$GREEN" "--- Development Tools (CLI) Installation Complete ---"
}

# If script is run directly (not sourced), execute the function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_dev_tools
fi