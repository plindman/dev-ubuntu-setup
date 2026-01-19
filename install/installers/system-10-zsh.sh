#!/bin/bash

# Script to install zsh and Oh My Zsh.
# Pre-requisites: system-03-networking-tools.sh (for curl).
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.
# https://itsfoss.com/zsh-ubuntu/

APP_NAME="zsh and Oh My Zsh"
APP_COMMAND="zsh"

# Zsh Configuration Data
POWERLEVEL10K_URL="https://github.com/romkatv/powerlevel10k.git"
ZSH_PLUGINS=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "zsh-tab-title|https://github.com/trystan2k/zsh-tab-title"
)

install_zsh() {
    # Install zsh
    quiet_apt_install zsh

    # Install Oh My Zsh (non-interactively)
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        # Run with --unattended to prevent it from changing the shell or starting zsh
        # --keep-zshrc ensures it doesn't overwrite a .zshrc if one exists
        local script
        script=$(download_and_validate_script "https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh") || return 1
        bash "$script" "" --unattended --keep-zshrc > /dev/null 2>&1
        rm -f "$script"
    fi

    # Set zsh as the default shell for the current user
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        sudo chsh -s "$(command -v zsh)" "$(whoami)"
    fi

    # Configure Zsh Plugins & Theme
    # Source: https://linuxconfig.org/shell-upgrade-supercharge-your-terminal-with-zsh-oh-my-zsh
    
    print_info "Installing Powerlevel10k theme..."
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone "$POWERLEVEL10K_URL" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" -q
    fi
    
    print_info "Installing Zsh Plugins..."
    for plugin in "${ZSH_PLUGINS[@]}"; do
        local name="${plugin%%|*}"
        local url="${plugin#*|}"
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name" ]; then
            git clone "$url" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name" -q
        fi
    done
}

verify_zsh() {
    if ! command_exists "zsh"; then
        return 1
    fi
    
    # Verify OMZ and Plugins
    if [ ! -d "$HOME/.oh-my-zsh" ]; then return 1; fi
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then return 1; fi
    
    for plugin in "${ZSH_PLUGINS[@]}"; do
        local name="${plugin%%|*}"
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name" ]; then return 1; fi
    done
    
    return 0
}
