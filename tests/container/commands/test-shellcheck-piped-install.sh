#!/bin/bash
# Internal command: test-shellcheck-piped-install
# Test ShellCheck validation for piped bash installs

set -e
echo "==> [INFO] Running as: $(whoami) (ID: $(id -u))"
cd "$CONTAINER_SRC"
echo "==> [INFO] Testing ShellCheck piped install validation..."
bash "$CONTAINER_SRC/tests/container/scripts/test_shellcheck_piped_install.sh"
