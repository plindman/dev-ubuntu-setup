#!/bin/bash
# Test Bun installer with ShellCheck validation

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Construct Command using Template
CMD_STRING=$(get_test_command "test_bun_install")

# Run Test
echo "==> Starting Bun Install Test..."
run_test_container "$CMD_STRING"
