#!/bin/bash

# Script to install zsh and Oh My Zsh.
# Pre-requisites: system-02-networking-tools.sh (for curl).
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.
# https://itsfoss.com/zsh-ubuntu/

APP_NAME="zsh and Oh My Zsh"
APP_COMMAND="zsh"

install_zsh() {
    # Install zsh
    quiet_apt_install zsh

    # Install Oh My Zsh (non-interactively)
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        # Run with --unattended to prevent it from changing the shell or starting zsh
        # --keep-zshrc ensures it doesn't overwrite a .zshrc if one exists
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc > /dev/null 2>&1
    fi

    # Set zsh as the default shell for the current user
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        sudo chsh -s "$(command -v zsh)" "$(whoami)"
    fi
}

# Source shared installation helper
