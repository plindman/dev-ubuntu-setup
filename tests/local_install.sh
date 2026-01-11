#!/bin/bash
# dev-install.sh - Test version that sources root install.sh

set -e

# Auto-discover project root relative to this script (assumed to be in tests/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEV_SOURCE="$(dirname "$SCRIPT_DIR")"

# Source the root install.sh to get all functions
source "$DEV_SOURCE/install.sh"

copy_local_repository() {
    print_step "Copying local repository to $TARGET_DIR..."
    # We copy the content of DEV_SOURCE (the mounted repo) to TARGET_DIR (the temp dir)
    # We use -a to preserve permissions/mode
    cp -a "$DEV_SOURCE/." "$TARGET_DIR/"
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