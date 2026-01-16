#!/bin/bash
# Test Bun installer with ShellCheck validation

set -e

echo '==> [Container] Loading Library...'
source install/lib/module_runner.sh

# Setup Logging
setup_logging "test-bun-install"

echo '==> [Container] Installing minimal essentials (curl, ca-certificates, shellcheck, unzip)...'
quiet_apt_update
sudo apt-get install -y curl ca-certificates shellcheck unzip > /dev/null 2>&1

echo '==> [Container] Verifying ShellCheck is installed...'
command -v shellcheck &> /dev/null || {
    echo "[ERROR] ShellCheck not found"
    exit 1
}
echo "[OK] ShellCheck available: $(shellcheck --version | head -n 1)"

echo '==> [Container] Testing Bun installer with ShellCheck validation...'
source install/lib/module_runner.sh
install_module "install/installers/dev-tools-12-bun.sh"

echo '==> [Container] Verifying Bun installation...'
if command -v bun &> /dev/null; then
    echo "[SUCCESS] Bun installed successfully: $(bun --version)"
else
    echo "[ERROR] Bun not found after installation"
    exit 1
fi

echo '==> [Container] Bun test completed successfully!'
