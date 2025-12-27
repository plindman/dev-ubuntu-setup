#!/bin/bash
#
# Script execution functions.

# Helper function to run a script if it exists
# Usage: run_script "$REPO_ROOT/install/system/core.sh"
run_script() {
    local script_path="$1"
    if [ -f "$script_path" ]; then
        bash "$script_path"
    else
        print_warning "Script not found at $script_path. Skipping."
    fi
}
