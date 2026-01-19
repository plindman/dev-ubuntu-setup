#!/bin/bash
# Test the full "New Machine"  using the local project.

set -e

# Initialize Test Environment
source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# 4. Run Test
echo "==> Starting Full test..."

CMD_STRING=$(get_test_command "test_full_from_source")

run_test_container "$CMD_STRING"

echo "==> [INFO] Full test completed. Check logs in tests/logs/ for details."