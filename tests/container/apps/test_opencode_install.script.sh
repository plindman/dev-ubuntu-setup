#!/bin/bash
# Test OpenCode installer with XDG-compliant installation verification

set -e

echo '==> [Container] Loading Library...'
source lib/module_runner.sh

# Setup Logging
setup_logging "test-opencode-install"

echo '==> [Container] Installing minimal essentials (curl, ca-certificates, shellcheck)...'
quiet_apt_update
sudo apt-get install -y curl ca-certificates shellcheck > /dev/null 2>&1

echo '==> [Container] Verifying ShellCheck is installed...'
command -v shellcheck &> /dev/null || {
    echo "[ERROR] ShellCheck not found"
    exit 1
}
echo "[OK] ShellCheck available: $(shellcheck --version | head -n 1)"

echo '==> [Container] Testing OpenCode installer with ShellCheck validation...'
install_module "installers/dev-tools-23-opencode.sh"

echo '==> [Container] Verifying OpenCode installation...'
if command -v opencode &> /dev/null; then
    echo "[SUCCESS] OpenCode installed successfully: $(opencode --version 2>&1 | head -n 1)"
else
    echo "[ERROR] OpenCode not found after installation"
    exit 1
fi

echo '==> [Container] Verifying XDG-compliant installation...'

# Check binary location
if [ -f "$HOME/.local/bin/opencode" ]; then
    echo "[OK] OpenCode binary found in XDG-compliant location: \$HOME/.local/bin/opencode"
else
    echo "[ERROR] OpenCode binary not found in \$HOME/.local/bin/opencode"
    command -v opencode
    exit 1
fi

# Verify no .opencode folder in home directory (XDG compliance)
if [ -d "$HOME/.opencode" ]; then
    echo "[ERROR] Found \$HOME/.opencode directory - not XDG compliant"
    exit 1
else
    echo "[OK] No \$HOME/.opencode directory (XDG compliant)"
fi

# Check XDG data directory
if [ -d "$HOME/.local/share/opencode" ]; then
    echo "[OK] XDG data directory exists: \$HOME/.local/share/opencode"
else
    echo "[ERROR] XDG data directory not found: \$HOME/.local/share/opencode"
    exit 1
fi

# Check XDG config directory
if [ -d "$HOME/.config/opencode" ]; then
    echo "[OK] XDG config directory exists: \$HOME/.config/opencode"
else
    echo "[ERROR] XDG config directory not found: \$HOME/.config/opencode"
    exit 1
fi

echo '==> [Container] OpenCode XDG compliance test completed successfully!'
