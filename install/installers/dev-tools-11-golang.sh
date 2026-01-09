#!/bin/bash

# Script to install Go (Golang) via mise.
# Pre-requisites: dev-tools-02-mise.sh.
# This corresponds to the "Development Tools (CLI)" -> "Languages & Runtimes" category.

APP_NAME="Go (Golang)"

install_golang() {
    print_info "Installing Go (latest) via mise..."
    
    # Ensure mise is in PATH for the current session
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if ! command_exists "mise"; then
        print_error "mise not found. Please ensure dev-tools-02-mise.sh ran successfully."
        exit 1
    fi

    # Install Go
    mise use --global go@latest
}

verify_golang() {
    if command_exists "go"; then
        return 0
    else
        return 1
    fi
}
