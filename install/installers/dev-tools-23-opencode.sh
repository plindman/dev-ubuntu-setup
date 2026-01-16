#!/bin/bash

# Script to install OpenCode (anomalyco/opencode).
# This corresponds to the "Development Tools (CLI)" -> "AI/ML Tools" category in SOFTWARE_INDEX.md.
# https://deepwiki.com/anomalyco/opencode/1.2-installation-and-setup

APP_NAME="OpenCode"
APP_COMMAND="opencode"

install_opencode() {
    # Install OpenCode via official install script
    # Ensure XDG-compliant installation to $HOME/.local/bin by setting XDG_BIN_DIR
    # Installation directory priority: OPENCODE_INSTALL_DIR > XDG_BIN_DIR > HOME/bin > HOME/.opencode/bin
    local script
    script=$(download_and_validate_script "https://opencode.ai/install") || return 1

    # TEMP FIX: The installer hardcodes INSTALL_DIR=$HOME/.opencode/bin instead of
    # respecting XDG_BIN_DIR. Patch the script to use XDG-compliant path.
    if grep -q 'INSTALL_DIR=$HOME/.opencode/bin' "$script"; then
        sed -i 's|INSTALL_DIR=\$HOME/.opencode/bin|INSTALL_DIR=$HOME/.local/bin|g' "$script"
    fi

    # Run installer with --no-modify-path to prevent .bashrc modification
    bash "$script" --no-modify-path || true
    rm -f "$script"

    # Verify installation by checking for binary
    if [ ! -f "$HOME/.local/bin/opencode" ]; then
        echo "[ERROR] OpenCode binary not found after installation"
        return 1
    fi

    # Ensure ~/.local/bin is in PATH for the current session
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi
}
