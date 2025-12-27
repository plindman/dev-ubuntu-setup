#!/bin/bash

# Script to install zsh and Oh My Zsh.
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.
# https://itsfoss.com/zsh-ubuntu/

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of zsh and Oh My Zsh"

# 1. Install zsh
install_and_show_versions zsh

# 2. Install Oh My Zsh (non-interactively)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_color "$GREEN" "Installing Oh My Zsh..."
    # We run with --unattended to prevent it from changing the shell or starting zsh.
    # --keep-zshrc ensures it doesn't overwrite a .zshrc if one exists.
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
    print_color "$GREEN" "Oh My Zsh is already installed. Skipping."
fi

# 3. Set zsh as the default shell for the current user
if [ "$SHELL" != "$(which zsh)" ]; then
    print_color "$GREEN" "Setting zsh as the default shell for $(whoami)..."
    # The chsh command requires the user's password to change the shell.
    sudo chsh -s "$(which zsh)" "$(whoami)"
    print_color "$YELLOW" "Default shell changed to zsh. Please log out and back in for the change to take effect."
else
    print_color "$GREEN" "zsh is already the default shell."
fi

print_color "$GREEN" "zsh and Oh My Zsh installation complete."