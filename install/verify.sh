#!/bin/bash

# Verification functions for GUI applications.
# Source this file to use verification functions in install scripts.

# Check if a command exists - used by all verify functions
_command_exists() {
    command -v "$1" &> /dev/null
}

# Web Browsers
verify_chrome() {
    _command_exists google-chrome
}

verify_brave() {
    _command_exists brave-browser
}

verify_vivaldi() {
    _command_exists vivaldi
}

# Development Applications
verify_vscode() {
    _command_exists code
}

verify_ghostty() {
    _command_exists ghostty
}

verify_antigravity() {
    _command_exists antigravity
}

# Display all installation status
show_all_status() {
    echo "GUI Applications Installation Status:"
    echo "======================================"
    echo "Chrome:          $(verify_chrome && echo 'Installed' || echo 'Not installed')"
    echo "Brave Browser:   $(verify_brave && echo 'Installed' || echo 'Not installed')"
    echo "Vivaldi:         $(verify_vivaldi && echo 'Installed' || echo 'Not installed')"
    echo "VS Code:         $(verify_vscode && echo 'Installed' || echo 'Not installed')"
    echo "Ghostty:         $(verify_ghostty && echo 'Installed' || echo 'Not installed')"
    echo "Antigravity:     $(verify_antigravity && echo 'Installed' || echo 'Not installed')"
}
