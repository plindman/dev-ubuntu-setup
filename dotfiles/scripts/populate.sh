#!/bin/bash

# Comprehensive script to populate chezmoi based on the dotfiles/README.md plan.
set -e

# 1. Initialize chezmoi
chezmoi init

# Source local output helpers
source "$(dirname "${BASH_SOURCE[0]}")/lib/output.sh"

# 2. Helper function to add if exists
add_if_exists() {
    if [ -e "$1" ]; then
        print_info "Adding $1..."
        chezmoi add "$1"
    else
        # Silent skip or low-level info
        :
    fi
}

print_header "Populating Chezmoi from Home Directory"

# --- Rule 3: Root Home Files ---
add_if_exists ~/.zshrc
add_if_exists ~/.zshenv
add_if_exists ~/.p10k.zsh
add_if_exists ~/.gitconfig
add_if_exists ~/.gitignore_global
add_if_exists ~/.npmrc

# --- Rule 2: Dedicated Home Sub-directories ---
add_if_exists ~/.oh-my-zsh/custom
add_if_exists ~/.gemini

# --- Rule 1: XDG Configurations (~/.config) ---
# Editors
add_if_exists ~/.config/nvim
add_if_exists ~/.config/micro/settings.json
add_if_exists ~/.config/nano/nanorc

# Tools
add_if_exists ~/.config/tmux/tmux.conf
add_if_exists ~/.config/tmux/tmux.conf.local
add_if_exists ~/.config/htop/htoprc
add_if_exists ~/.config/gh/config.yml
add_if_exists ~/.config/uv/uv.toml

# GUI Apps
add_if_exists ~/.config/ghostty/config
add_if_exists ~/.config/Code/User/settings.json
add_if_exists ~/.config/Code/User/keybindings.json
add_if_exists ~/.config/Antigravity
add_if_exists ~/.config/nemo

echo ""
echo "=== Population Complete ==="
echo "Source path: $(chezmoi source-path)"
echo "You can now push the source directory to your new dotfiles GitHub repo."