#!/bin/bash
# Test the full "New Machine" Developer Experience (DX) using the local project.
# Uses a cached base image for speed.

set -e

# 1. Identify locations
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOG_DIR="$SCRIPT_DIR/logs"

# 2. Variables
CONTAINER_NAME="dev-ubuntu-setup"
CONTAINER_USER="ubuntu"  # Change this once, and everything updates
CONTAINER_HOME="/home/$CONTAINER_USER"
CONTAINER_SRC="$CONTAINER_HOME/$CONTAINER_NAME"
CONTAINER_LOGS="$CONTAINER_HOME/.local/state/$CONTAINER_NAME"

# 3. Preparation
# Ensure the host logs folder exists for mounting
mkdir -p "$LOG_DIR"

# 4. Build the base image
# Pass host UID/GID so the container user matches your host user
docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg USERNAME="$CONTAINER_USER" \
    -t "$CONTAINER_NAME" \
    -f "$SCRIPT_DIR/Dockerfile" \
    "$PROJECT_ROOT"

# 5. Run the test
docker run --rm \
    --name "$CONTAINER_NAME" \
    -v "$PROJECT_ROOT:$CONTAINER_SRC" \
    -v "$LOG_DIR:$CONTAINER_LOGS" \
    "$CONTAINER_NAME" bash -c "
    set -e
    echo \"==> [INFO] Running as: \$(whoami) (ID: \$(id -u))\"
    cd \"$CONTAINER_SRC\"
    bash install.sh
"

# 6. Completion message
echo "==> [INFO] DX test completed. Check logs in tests/logs/ for details."