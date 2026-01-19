#!/bin/bash
# Test the 'apps' category installers

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Construct Command using Template
CMD_STRING=$(get_test_command "test_apps")

# Run Test
echo "==> Starting Category Test: apps..."
run_test_container "$CMD_STRING"
