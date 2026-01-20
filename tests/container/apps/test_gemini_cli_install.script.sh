#!/bin/bash
# Test Gemini CLI installer with extension installation

set -e

echo '==> [Container] Loading Library...'
source lib/module_runner.sh

# Setup Logging
setup_logging "test-gemini-cli-install"

echo '==> [Container] Installing minimal essentials (curl, ca-certificates)...'
quiet_apt_update
sudo apt-get install -y curl ca-certificates > /dev/null 2>&1

echo '==> [Container] Installing mise (required for Node.js)...'
install_module "installers/dev-tools-02-mise.sh"

echo '==> [Container] Installing Node.js (required for gemini-cli)...'
install_module "installers/dev-tools-10-nodejs.sh"

echo '==> [Container] Testing Gemini CLI installer with extensions...'
install_module "installers/dev-tools-21-gemini-cli.sh"

echo '==> [Container] Verifying Gemini CLI installation...'
if command -v gemini &> /dev/null; then
    echo "[SUCCESS] Gemini CLI installed successfully: $(gemini --version 2>&1 | head -n 1)"
else
    echo "[ERROR] Gemini CLI not found after installation"
    exit 1
fi

echo '==> [Container] Verifying extensions are installed...'
# Check if extensions directory exists and contains installed extensions
if [ -d "$HOME/.gemini/extensions" ]; then
    echo "[OK] Extensions directory exists: \$HOME/.gemini/extensions"

    # Count installed extensions (each extension creates a directory)
    extension_count=$(find "$HOME/.gemini/extensions" -mindepth 1 -maxdepth 1 -type d | wc -l)
    echo "[INFO] Found $extension_count extension(s) installed"

    # List installed extensions
    find "$HOME/.gemini/extensions" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | while read ext; do
        echo "[OK] Extension installed: $ext"
    done

    if [ "$extension_count" -ge 3 ]; then
        echo "[SUCCESS] All expected extensions installed"
    else
        echo "[WARNING] Expected at least 3 extensions, found $extension_count"
    fi
else
    echo "[ERROR] Extensions directory not found: \$HOME/.gemini/extensions"
    exit 1
fi

echo '==> [Container] Gemini CLI test completed successfully!'
