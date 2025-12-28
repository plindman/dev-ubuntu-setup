#!/bin/bash

# Setup script for zsh configuration
# Symlinks .zshrc, .p10k.zsh and oh-my-zsh custom files

set -e

# Source local output helpers
source "$(dirname "${BASH_SOURCE[0]}")/lib/output.sh"

print_header "Zsh Configuration Setup"

# Get the directory where this script is located for internal use
# We use a local variable (technically global in main, but standard naming)
# or just calculate it when needed.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"


# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_error "Oh My Zsh not found at ~/.oh-my-zsh"
    print_info "Please install Oh My Zsh first"
    exit 1
fi

# Symlink .zshrc
print_color "$GREEN" "Symlinking .zshrc..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Symlink .p10k.zsh
print_color "$GREEN" "Symlinking .p10k.zsh..."
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Setup oh-my-zsh custom files
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
DOTFILES_CUSTOM="$DOTFILES_DIR/oh-my-zsh/custom"

# Symlink custom aliases and scripts
print_color "$GREEN" "Symlinking oh-my-zsh custom files..."
ln -sf "$DOTFILES_CUSTOM/aliases.zsh" "$ZSH_CUSTOM/aliases.zsh"
ln -sf "$DOTFILES_CUSTOM/aliases_dev.zsh" "$ZSH_CUSTOM/aliases_dev.zsh"
ln -sf "$DOTFILES_CUSTOM/_path.zsh" "$ZSH_CUSTOM/_path.zsh"

# Setup external plugins
EXTERNAL_PLUGINS=(
    "zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting"
    "zsh-tab-title https://github.com/romkatv/zsh-tab-title"
)

for plugin_info in "${EXTERNAL_PLUGINS[@]}"; do
    read -r plugin_name plugin_url <<< "$plugin_info"
    plugin_path="$ZSH_CUSTOM/plugins/$plugin_name"

    if [ ! -d "$plugin_path" ]; then
        print_color "$GREEN" "Cloning $plugin_name..."
        git clone --quiet "$plugin_url" "$plugin_path"
    else
        print_color "$CYAN" "$plugin_name already installed. Updating..."
        (cd "$plugin_path" && git pull --quiet)
    fi
done

print_success "Zsh configuration complete!"
print_info "Restart your shell or run 'source ~/.zshrc' to apply changes."
