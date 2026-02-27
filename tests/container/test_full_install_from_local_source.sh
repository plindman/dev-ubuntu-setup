#!/bin/bash
# Test the full installation from local source.

set -e

# Initialize Test Environment
source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Run Test
echo "==> Starting Full Install test..."

CMD_STRING=$(get_test_command "test_full_install_from_local_source")

run_test_container "$CMD_STRING"

echo "==> [INFO] Full install test completed. Check logs in tests/logs/ for details."