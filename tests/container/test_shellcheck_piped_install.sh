#!/bin/bash
# Test ShellCheck validation for piped bash installs

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Construct Command using Template
CMD_STRING=$(get_test_command "test-shellcheck-piped-install")

# Run Test
echo "==> Starting ShellCheck Piped Install Test..."
run_test_container "$CMD_STRING" "${CONTAINER_NAME}-shellcheck"
