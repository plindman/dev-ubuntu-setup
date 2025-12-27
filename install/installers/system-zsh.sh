#!/bin/bash

# Script to install zsh and Oh My Zsh.
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.
# https://itsfoss.com/zsh-ubuntu/

APP_NAME="zsh and Oh My Zsh"
APP_COMMAND="zsh"

install_zsh() {
    # Install zsh
    install_and_show_versions zsh

    # Install Oh My Zsh (non-interactively)
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        # Run with --unattended to prevent it from changing the shell or starting zsh
        # --keep-zshrc ensures it doesn't overwrite a .zshrc if one exists
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    fi

    # Set zsh as the default shell for the current user
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        sudo chsh -s "$(command -v zsh)" "$(whoami)"
    fi
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
