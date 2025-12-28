#!/bin/bash

# Verification script for the Development Workstation Setup
# Checks installation status of all components.

set -e

# Set script directory
MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source module runner
source "$MY_DIR/install/lib/module_runner.sh"

# --- Verification Wrappers ---
verify_all() {
    print_header "Starting Full Verification"
    verify_category "system"
    verify_category "devtools"
    verify_category "desktop"
    verify_category "apps"
    print_header "Verification Complete!"
}

# Run verification
verify_all
