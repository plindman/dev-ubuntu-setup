#!/bin/bash

# Script to install System Tools.
# This corresponds to the "System" -> "System Tools" category in SOFTWARE_INDEX.md.

APP_NAME="System Tools"
APP_COMMAND=("htop" "keychain" "rg" "fzf" "fd")

install_system_tools() {
    quiet_apt_install htop keychain ripgrep fzf fd-find
}

verify_system_tools() {
    # fd-find provides the 'fd' command
    command_exists "htop" || return 1
    command_exists "keychain" || return 1
    command_exists "rg" || return 1
    command_exists "fzf" || return 1
    command_exists "fd" || return 1
}

verify_details_system_tools() {
    print_color "$YELLOW" "   Missing:"
    command_exists "htop" || print_color "$YELLOW" "     - htop"
    command_exists "keychain" || print_color "$YELLOW" "     - keychain"
    command_exists "rg" || print_color "$YELLOW" "     - ripgrep (rg)"
    command_exists "fzf" || print_color "$YELLOW" "     - fzf"
    command_exists "fd" || print_color "$YELLOW" "     - fd (from fd-find package)"
}

# Source shared installation helper
