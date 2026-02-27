#!/bin/bash

# Script to install zoxide (smart directory navigation).
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.

APP_NAME="zoxide"
APP_COMMAND="zoxide"

install_zoxide() {
    print_info "Installing zoxide..."
    if ! command_exists zoxide; then
        local script
        script=$(download_and_validate_script "https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh") || return 1
        bash "$script" > /dev/null 2>&1
        rm -f "$script"
    fi

    # Ensure ~/.local/bin is in PATH for the current session if it isn't already
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi
}

verify_zoxide() {
    command_exists zoxide || return 1
    return 0
}
