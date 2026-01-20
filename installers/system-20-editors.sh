#!/bin/bash

# Script to install all CLI editors: nano, micro, and neovim.
# This corresponds to the "System" -> "Editors" category in SOFTWARE_INDEX.md.

APP_NAME="CLI Editors"
APP_COMMAND=("nano" "micro" "nvim" "notepadqq")

install_editors() {
    quiet_apt_install nano micro neovim notepadqq

    # Clone LazyVim starter if not already present
    if [ ! -d "$HOME/.config/nvim" ]; then
        git clone https://github.com/LazyVim/starter ~/.config/nvim
        rm -rf ~/.config/nvim/.git
    fi
}

verify_editors() {
    # Check all editors are installed
    for cmd in "${APP_COMMAND[@]}"; do
        command_exists "$cmd" || return 1
    done

    # Check LazyVim is set up
    [ -d "$HOME/.config/nvim" ] || return 1
}

verify_details_editors() {
    print_color "$YELLOW" "   Missing:"
    for cmd in "${APP_COMMAND[@]}"; do
        if ! command_exists "$cmd"; then
            print_color "$YELLOW" "     - $cmd (editor)"
        fi
    done
    if [ ! -d "$HOME/.config/nvim" ]; then
        print_color "$YELLOW" "     - LazyVim configuration"
    fi
}
