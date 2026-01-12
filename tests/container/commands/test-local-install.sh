#!/bin/bash
# Internal command: test-local-install
# Test the full "New Machine" Developer Experience (DX) using the local project.

set -e
echo "==> [INFO] Running as: $(whoami) (ID: $(id -u))"
cd "$CONTAINER_SRC"
echo "==> [INFO] Running local install.sh (simulating clone from github)"
bash "$CONTAINER_SRC/tests/container/scripts/install_from_source.sh"
