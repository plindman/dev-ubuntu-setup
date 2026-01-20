#!/bin/bash

# Script to install lazygit (terminal UI for git).
# Pre-requisites: system-00-core.sh (for curl), dev-tools-03-git.sh (git).
# This corresponds to the "Development Tools (CLI)" -> "Git" category in SOFTWARE_INDEX.md.

APP_NAME="lazygit"
APP_COMMAND="lazygit"

install_lazygit() {
    print_info "Installing $APP_NAME..."

    local version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    local tmp_archive=$(download_file "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_x86_64.tar.gz") || return 1

    tar xf "$tmp_archive" lazygit
    install lazygit -D -t "$HOME/.local/bin/"
    rm -f "$tmp_archive"

    print_success "$APP_NAME installation complete."
}
