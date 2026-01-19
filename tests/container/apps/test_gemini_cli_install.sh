#!/bin/bash
# Test Gemini CLI installer with extension installation

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Construct Command using Template
CMD_STRING=$(get_test_command "test_gemini_cli_install")

# Run Test
echo "==> Starting Gemini CLI Install Test..."
run_test_container "$CMD_STRING"
