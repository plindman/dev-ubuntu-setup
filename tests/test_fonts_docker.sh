#!/bin/bash
# Focused test for Font Installers only

set -e

# 1. Identify locations
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOG_DIR="$SCRIPT_DIR/logs"

# 2. Load Configuration and Utilities
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/docker_utils.sh"

CONTAINER_NAME="${CONTAINER_NAME_BASE}-fonts"

# 3. Build Image
ensure_test_image "$SCRIPT_DIR" "$CONTAINER_IMAGE" "$CONTAINER_USER"

# 4. Run Test
echo "==> Starting Font test..."
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
    cd "$CONTAINER_SRC"
    
    # Source the library (loads output, utils, apt, fonts)
    source install/lib/module_runner.sh
    
    # Ensure dependencies (core + networking) via proper modules
    quiet_apt_update
    source install/installers/system-01-core.sh
    install_core
    source install/installers/system-02-networking-tools.sh
    install_networking_tools
    
    echo ''
    print_header 'Testing Dev Fonts (system-08)...'
    source install/installers/system-08-dev-fonts.sh
    install_fonts
    
    echo ''
    print_header 'Testing Writing Fonts (system-09)...'
    source install/installers/system-09-writing-fonts.sh
    install_writing_fonts
    "