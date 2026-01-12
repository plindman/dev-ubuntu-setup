#!/bin/bash
# Docker utilities for testing

# Note: This file is sourced by config.sh, so variables like TESTS_ROOT are available.

# Build/Ensure the test image exists
# Usage: ensure_test_image [SCRIPT_DIR] [IMAGE_NAME] [USER]
ensure_test_image() {
    local script_dir="${1:-$TESTS_ROOT}"
    local container_image="${2:-$CONTAINER_IMAGE}"
    local container_user="${3:-$CONTAINER_USER}"
    
    echo "==> Ensuring base test image ($container_image)..."
    docker build \
        --build-arg USER_ID=$(id -u) \
        --build-arg GROUP_ID=$(id -g) \
        --build-arg USERNAME="$container_user" \
        -t "$container_image" \
        - < "$script_dir/Dockerfile"
}

# Helper to construct a docker command string from an internal test command
# Usage: get_test_command "COMMAND_NAME" [KEY=VALUE ...]
# Example: get_test_command "test-category" "CATEGORY=writing"
get_test_command() {
    local cmd_name="$1"
    shift
    
    local cmd_path="$TESTS_COMMANDS_DIR/${cmd_name}.sh"
    
    if [ ! -f "$cmd_path" ]; then
        echo "ERROR: Command not found at $cmd_path" >&2
        return 1
    fi
    
    local content=$(cat "$cmd_path")
    
    # Perform substitutions
    for kv in "$@"; do
        local key="${kv%%=*}"
        local val="${kv#*=}"
        # Replace {{KEY}} with VALUE
        content="${content//\{\{$key\}\}/$val}"
    done
    
    echo "bash -s << 'EOF'
$content
EOF"
}

# Run a command inside the test container
# Usage: run_test_container "COMMAND" [CONTAINER_NAME]
# Relies on global variables from config.sh
run_test_container() {
    local command="$1"
    local container_name="${2:-$CONTAINER_NAME}"

    # Use globals
    local container_image="${CONTAINER_IMAGE}"
    local container_src="${CONTAINER_SRC}"
    local container_logs="${CONTAINER_LOGS}"
    local project_root="${PROJECT_ROOT}"
    local log_dir="${TESTS_LOG_DIR}"

    if [ -z "$command" ]; then
        echo "ERROR: No command provided to run_test_container"
        return 1
    fi

    # Ensure logs dir exists (Safety net)
    mkdir -p "$log_dir"

    # Cleanup any stale container
    docker rm -f "$container_name" >/dev/null 2>&1 || true

    # Run the container
    # Order: Options -> Identity -> Environment -> Volumes -> Image -> Command
    docker run --rm \
        --name "$container_name" \
        -e REPO_URL="$container_src" \
        -e CONTAINER_SRC="$container_src" \
        -v "$project_root:$container_src" \
        -v "$log_dir:$container_logs" \
        "$container_image" \
        bash -c "$command"
}
