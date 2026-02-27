#!/bin/bash
# Test dry-run mode using local source

set -e

# Initialize Test Environment
source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# Run Test
echo "==> Starting Dry-run test..."

CMD_STRING=$(get_test_command "test_dry_run_from_local_source")

run_test_container "$CMD_STRING"

echo "==> [INFO] Dry-run test completed. Check logs in tests/logs/ for details."
