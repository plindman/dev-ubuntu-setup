#!/bin/bash
# Test the full "New Machine" Developer Experience (DX) using the local project.

set -e

# 1. Identify locations
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR_NAME=$(basename "$SCRIPT_DIR")
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOG_DIR="$SCRIPT_DIR/logs"

# 2. Load Configuration and Utilities
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/docker_utils.sh"

CONTAINER_NAME="${CONTAINER_NAME_BASE}-local"

# 3. Build Image
ensure_test_image "$SCRIPT_DIR" "$CONTAINER_IMAGE" "$CONTAINER_USER"

# 4. Run Test
echo "==> Starting DX test..."
# Signature: NAME IMAGE SRC_CONT LOG_CONT SRC_HOST LOG_HOST CMD
run_test_container \
    "$CONTAINER_NAME" \
    "$CONTAINER_IMAGE" \
    "$CONTAINER_SRC" \
    "$CONTAINER_LOGS" \
    "$PROJECT_ROOT" \
    "$LOG_DIR" \
    "\
    set -e
    echo \"==> [INFO] Running as: $(whoami) (ID: $(id -u))\"
    cd \"$CONTAINER_SRC\"
    echo \"==> [INFO] Running local install.sh (simulating clone from github)\"
    bash \"$CONTAINER_SRC/$SCRIPT_DIR_NAME/local_install.sh\"
    "

echo "==> [INFO] DX test completed. Check logs in tests/logs/ for details."
