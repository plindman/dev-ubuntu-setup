#!/bin/bash
# Internal command: test-bun-install
# Test Bun installer with ShellCheck validation

set -e
echo "==> [INFO] Running as: $(whoami) (ID: $(id -u))"
cd "$CONTAINER_SRC"
echo "==> [INFO] Testing Bun installer with ShellCheck..."
bash "$CONTAINER_SRC/tests/container/scripts/test_bun_install.sh"
