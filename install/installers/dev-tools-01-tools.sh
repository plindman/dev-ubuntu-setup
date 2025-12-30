#!/bin/bash
APP_NAME="Build Tools"
APP_COMMAND=("make" "rg")

install_tools() {
    install_and_show_versions build-essential ripgrep
}

verify_details_tools() {
    local missing=()
    
    if ! command_exists "make"; then
        missing+=("build-essential (make)")
    fi
    
    if ! command_exists "rg"; then
        missing+=("ripgrep (rg)")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}