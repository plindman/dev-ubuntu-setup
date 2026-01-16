#!/bin/bash
# Internal command: test-opencode-install
# Test OpenCode installer with XDG-compliant installation verification

set -e
echo "==> [INFO] Running as: $(whoami) (ID: $(id -u))"
cd "$CONTAINER_SRC"
echo "==> [INFO] Testing OpenCode installer with XDG-compliant installation..."
bash "$CONTAINER_SRC/tests/container/scripts/test_opencode_install.sh"
