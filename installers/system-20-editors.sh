#!/bin/bash

# Script to install all CLI editors: nano, micro, and neovim.
# Pre-requisites: system-00-core.sh (for git), dev-tools-10-nodejs.sh (for npm/tree-sitter-cli).
# This corresponds to the "System" -> "Editors" category in SOFTWARE_INDEX.md.

APP_NAME="CLI Editors"
APP_COMMAND=("nano" "micro" "nvim" "notepadqq")

install_editors() {
    # Add neovim PPA for latest version (Ubuntu's version is frozen)
    sudo add-apt-repository -y ppa:neovim-ppa/stable > /dev/null 2>&1
    quiet_apt_update

    # Install editors
    quiet_apt_install nano micro neovim notepadqq

    # Install tree-sitter CLI for nvim-treesitter (LazyVim requirement)
    if command_exists "npm"; then
        npm install -g tree-sitter-cli
    fi

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

    # Check tree-sitter CLI (optional, for nvim-treesitter)
    if command_exists "npm"; then
        command_exists "tree-sitter" || return 1
    fi
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
    if command_exists "npm" && ! command_exists "tree-sitter"; then
        print_color "$YELLOW" "     - tree-sitter-cli (for nvim-treesitter)"
    fi
}
