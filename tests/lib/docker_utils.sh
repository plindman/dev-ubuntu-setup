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

# Helper to construct a docker command string to run a test script
# Usage: get_test_command "SCRIPT_NAME"
# Example: get_test_command "test_bun_install"
get_test_command() {
    local script_name="$1"

    # Find the runner's location (runs on host)
    local runner_path=$(find "$TESTS_ROOT/container" -name "${script_name}.sh" -type f | head -n 1)

    if [ -z "$runner_path" ]; then
        echo "ERROR: Runner not found: ${script_name}.sh"
        return 1
    fi

    # Extract relative path from tests/container/
    local relative_path=${runner_path#$TESTS_ROOT/container/}
    local script_dir=$(dirname "$relative_path")

    # Inline template for running test scripts
    # Note: Use single quotes for variables that should expand in container,
    #       escape dollar signs for variables that expand now
    local template="#!/bin/bash
set -e
echo \"==> [INFO] Running as: \$(whoami) (ID: \$(id -u))\"
cd \"\$CONTAINER_SRC\"
echo \"==> [INFO] Testing...\"
script_path=\"\$CONTAINER_SRC/tests/container/${script_dir}/${script_name}.script.sh\"
if [ ! -f \"\$script_path\" ]; then
    echo \"ERROR: Test script not found: \$script_path\"
    exit 1
fi
bash \"\$script_path\""

    echo "bash -s << 'EOF'
$template
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

    # Return the exit code from docker run
    return $?
}
