#!/bin/bash

# Script to install Node.js via mise.
# Pre-requisites: dev-tools-02-mise.sh.
# This corresponds to the "Development Tools (CLI)" -> "Languages & Runtimes" category.

APP_NAME="Node.js"

install_nodejs() {
    print_info "Installing Node.js (latest LTS) via mise..."
    
    # Ensure mise is in PATH for the current session
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if ! command_exists "mise"; then
        print_error "mise not found. Please ensure dev-tools-02-mise.sh ran successfully."
        exit 1
    fi

    # Install Node.js
    mise use --global node@lts
}

verify_nodejs() {
    if command_exists "node"; then
        return 0
    else
        return 1
    fi
}