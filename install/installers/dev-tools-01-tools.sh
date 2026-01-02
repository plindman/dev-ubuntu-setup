#!/bin/bash
APP_NAME="CLI Development Tools (Build Essentials, rg, fzf)"
APP_COMMAND=("make" "rg" "fzf")

install_tools() {
    install_and_show_versions build-essential ripgrep fzf
}

verify_details_tools() {
    local missing=()
    
    if ! command_exists "make"; then
        missing+=("build-essential (make)")
    fi
    
    if ! command_exists "rg"; then
        missing+=("ripgrep (rg)")
    fi

    if ! command_exists "fzf"; then
        missing+=("fzf")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}