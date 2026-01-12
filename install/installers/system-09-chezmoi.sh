#!/bin/bash

# Script to install chezmoi (dotfiles manager).
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.

APP_NAME="chezmoi"
APP_COMMAND="chezmoi"

install_chezmoi() {
    print_info "Installing chezmoi..."
    # Install to ~/.local/bin
    # We use -b to specify the binary directory
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" > /dev/null 2>&1
    
    # Ensure ~/.local/bin is in PATH for the current session if it isn't already
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi
}
