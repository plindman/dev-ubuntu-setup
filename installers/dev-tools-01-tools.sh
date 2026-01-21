#!/bin/bash
APP_NAME="Build Essentials"
APP_COMMAND=("make" "gcc" "g++")

install_tools() {
    quiet_apt_install build-essential
}

verify_details_tools() {
    local missing=()

    if ! command_exists "make"; then
        missing+=("build-essential (make)")
    fi

    if ! command_exists "gcc"; then
        missing+=("build-essential (gcc)")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}