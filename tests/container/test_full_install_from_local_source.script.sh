#!/bin/bash
# test_full_install_from_local_source.script.sh - Test version that sources root install.sh

set -e

# Set custom log filename for this test
export LOG_FILE_NAME="test-full-install"

# Source the root install.sh to get all functions
# Note: CONTAINER_SRC is set by the container environment
source "$CONTAINER_SRC/install.sh"

# Override clone_repository to copy local instead of git clone
clone_repository() {
    print_step "Copying local repository to $TARGET_DIR..."
    # We copy the content of CONTAINER_SRC (the mounted repo) to TARGET_DIR (the temp dir)
    # We use -a to preserve permissions/mode
    cp -a "$CONTAINER_SRC/." "$TARGET_DIR/"
    cd "$TARGET_DIR"
}

# Execute if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run "$@"
fi