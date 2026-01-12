#!/bin/bash
# Test Configuration & Bootstrapper

# --- Project Identity ---
export APP_NAME="dev-ubuntu-setup"

# --- Host Locations (Tests) ---
# Directories related to the test suite itself
export TESTS_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export TESTS_ROOT="$(dirname "$TESTS_LIB_DIR")"
export TESTS_LOG_DIR="$TESTS_ROOT/logs"
export TESTS_COMMANDS_DIR="$TESTS_ROOT/commands"

# --- Host Locations (Project) ---
# The root of the repository, mounted into the container to test local code
export PROJECT_ROOT="$(dirname "$TESTS_ROOT")"

# --- Docker Configuration ---
export CONTAINER_IMAGE="$APP_NAME"
export CONTAINER_NAME="$APP_NAME"
export CONTAINER_USER="ubuntu"

# --- Container Locations ---
export CONTAINER_HOME="/home/$CONTAINER_USER"
export CONTAINER_SRC="$CONTAINER_HOME/$APP_NAME"
export CONTAINER_LOGS="$CONTAINER_HOME/.local/state/$APP_NAME"

# --- Initialization ---
if [ -f "$TESTS_LIB_DIR/docker_utils.sh" ]; then
    source "$TESTS_LIB_DIR/docker_utils.sh"
else
    echo "Error: docker_utils.sh not found at $TESTS_LIB_DIR"
    exit 1
fi

prepare_test_env() {
    # Ensure log directory exists
    if [ -n "$TESTS_LOG_DIR" ]; then
        mkdir -p "$TESTS_LOG_DIR"
    fi
    
    # Ensure test image exists (using globals)
    ensure_test_image
}
