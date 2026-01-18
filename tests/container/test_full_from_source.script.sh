#!/bin/bash
# dev-install.sh - Test version that sources root install.sh

set -e

# Auto-discover project root relative to this script
# NOTE: This script is co-located in tests/container/ (root), not in a subfolder
# like apps/ or category/, so we only go up 2 levels instead of 3.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Source the root install.sh to get all functions
source "$PROJECT_ROOT/install.sh"

copy_local_repository() {
    print_step "Copying local repository to $TARGET_DIR..."
    # We copy the content of PROJECT_ROOT (the mounted repo) to TARGET_DIR (the temp dir)
    # We use -a to preserve permissions/mode
    cp -a "$PROJECT_ROOT/." "$TARGET_DIR/"
    cd "$TARGET_DIR"
}

# Override run function to use copy instead of clone
run() {
    prepare_environment
    copy_local_repository  # <-- Only difference
    execute_installation "$@"
    verify_installation
}

# Execute
run "$@"