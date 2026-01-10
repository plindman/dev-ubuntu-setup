#!/bin/bash

# Script to install mise-en-place (runtime manager).
# This is a prerequisite for other runtimes like Node.js and Go.

APP_NAME="mise"

install_mise() {
    print_info "Installing mise..."
    curl -fsSL https://mise.run | sh > /dev/null 2>&1

    # Ensure ~/.local/bin is in PATH for the current session
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi
}

verify_mise() {
    if command_exists "mise" || [ -x "$HOME/.local/bin/mise" ]; then
        return 0
    else
        return 1
    fi
}
