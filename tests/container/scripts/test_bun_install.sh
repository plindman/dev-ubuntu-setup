#!/bin/bash
# Test Bun installer with ShellCheck validation

set -e

echo '==> [Container] Loading Library...'
source install/lib/module_runner.sh

# Setup Logging
setup_logging "test-bun-install"

echo '==> [Container] Installing System Layer (includes ShellCheck)...'
quiet_apt_update
install_category "system"

echo '==> [Container] Verifying ShellCheck is installed...'
command -v shellcheck &> /dev/null || {
    echo "[ERROR] ShellCheck not found"
    exit 1
}
echo "[OK] ShellCheck available: $(shellcheck --version | head -n 1)"

echo '==> [Container] Testing Bun installer with ShellCheck validation...'
install_module "install/installers/dev-tools-12-bun.sh"

echo '==> [Container] Verifying Bun installation...'
if command -v bun &> /dev/null; then
    echo "[SUCCESS] Bun installed successfully: $(bun --version)"
else
    echo "[ERROR] Bun not found after installation"
    exit 1
fi

echo '==> [Container] Bun test completed successfully!'
