#!/bin/bash
# Test OpenCode installer with XDG-compliant installation

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Construct Command using Template
CMD_STRING=$(get_test_command "test_opencode_install")

# Run Test
echo "==> Starting OpenCode Install Test..."
run_test_container "$CMD_STRING" "${CONTAINER_NAME}-opencode"
