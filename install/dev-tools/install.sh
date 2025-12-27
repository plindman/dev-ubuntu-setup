#!/bin/bash

# This script orchestrates the installation of all components in the 'dev-tools' category.
# The order of execution is important to handle dependencies.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

SCRIPT_DIR="$REPO_ROOT/install/dev-tools"

print_header "Running Development Tools (CLI) Installation Scripts"

# Update package lists once for all dev-tools scripts
print_color "$GREEN" "Updating package lists..."
sudo apt-get -qq update

# The order of execution is important here.
run_script "$SCRIPT_DIR/tools.sh"
run_script "$SCRIPT_DIR/git.sh"
run_script "$SCRIPT_DIR/nodejs.sh"
run_script "$SCRIPT_DIR/bun.sh"
run_script "$SCRIPT_DIR/uv.sh"
run_script "$SCRIPT_DIR/gemini-cli.sh"
run_script "$SCRIPT_DIR/claude-code.sh"
run_script "$SCRIPT_DIR/services.sh"

print_color "$GREEN" "--- Development Tools (CLI) Installation Complete ---"