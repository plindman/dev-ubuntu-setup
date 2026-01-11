#!/bin/bash
# Docker utilities for testing

# Build/Ensure the test image exists
# Usage: ensure_test_image "SCRIPT_DIR" "CONTAINER_IMAGE" "CONTAINER_USER"
ensure_test_image() {
    local script_dir="$1"
    local container_image="$2"
    local container_user="$3"
    
    echo "==> Ensuring base test image ($container_image)..."
    docker build \
        --build-arg USER_ID=$(id -u) \
        --build-arg GROUP_ID=$(id -g) \
        --build-arg USERNAME="$container_user" \
        -t "$container_image" \
        - < "$script_dir/Dockerfile"
}

# Run a command inside the test container
# Usage: run_test_container "CONTAINER_NAME" "CONTAINER_IMAGE" "CONTAINER_SRC" "CONTAINER_LOGS" "PROJECT_ROOT" "LOG_DIR" "COMMAND"
run_test_container() {
    local container_name="$1"
    local container_image="$2"
    local container_src="$3"
    local container_logs="$4"
    local project_root="$5"
    local log_dir="$6"
    local command="$7"

    # Ensure logs dir exists
    mkdir -p "$log_dir"

    # Cleanup any stale container
    docker rm -f "$container_name" >/dev/null 2>&1 || true

    # Run the container
    # Order: Options -> Identity -> Environment -> Volumes -> Image -> Command
    docker run --rm \
        --name "$container_name" \
        -e REPO_URL="$container_src" \
        -v "$project_root:$container_src" \
        -v "$log_dir:$container_logs" \
        "$container_image" \
        bash -c "$command"
}

