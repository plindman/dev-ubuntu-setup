#!/bin/bash

# Script to install tmux and Oh My Tmux.
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.

set -e
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Source the helper functions
source "$(dirname "$0")/../../lib/helpers.sh"

print_header "Starting installation of tmux and Oh My Tmux"

install_and_show_versions tmux

# Oh My Tmux
# The framework itself is expected to be cloned into $HOME/.local/share/oh-my-tmux
# Our XDG compliant ~/.config/tmux/tmux.conf will source it.
OHMYTMUX_INSTALL="$HOME/.local/share/oh-my-tmux" # XDG compliant location for the framework
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TMUX_XDG_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"

# Check for a legacy non-XDG installation of Oh My Tmux
if [ -d "$HOME/.tmux" ] && [ "$HOME/.tmux" != "$OHMYTMUX_INSTALL" ]; then
    print_color "$YELLOW" "Warning: A legacy installation of Oh My Tmux was found at ~/.tmux."
    print_color "$YELLOW" "This setup uses a different path ($OHMYTMUX_INSTALL) and will not touch the existing one."
    print_color "$YELLOW" "You may want to manually remove ~/.tmux to avoid conflicts."
fi

if [ ! -d "$OHMYTMUX_INSTALL" ]; then
    print_color "$GREEN" "Cloning Oh My Tmux repository into $OHMYTMUX_INSTALL..."
    git clone --single-branch https://github.com/gpakosz/.tmux.git "$OHMYTMUX_INSTALL"
else
    print_color "$GREEN" "Oh My Tmux repository already exists at $OHMYTMUX_INSTALL. Pulling latest changes..."
    # Ensure it's a git repository before pulling
    if [ -d "$OHMYTMUX_INSTALL/.git" ]; then
        (cd "$OHMYTMUX_INSTALL" && git pull)
    else
        print_color "$YELLOW" "Warning: $OHMYTMUX_INSTALL is not a Git repository. Skipping pull."
    fi
fi

# Create XDG compliant config directory if it doesn't exist
mkdir -p "$TMUX_XDG_CONFIG_DIR"

# Symlink the main .tmux.conf from the cloned repository to the XDG config location
if [ ! -f "$TMUX_XDG_CONFIG_DIR/tmux.conf" ]; then
    print_color "$GREEN" "Creating symlink for main tmux.conf..."
    ln -s "$OHMYTMUX_INSTALL/.tmux.conf" "$TMUX_XDG_CONFIG_DIR/tmux.conf"
else
    print_color "$GREEN" "Symlink for main tmux.conf already exists."
fi

# Copy the local customizations file to the XDG config location
# This is where users add their personal Oh My Tmux settings.
if [ ! -f "$TMUX_XDG_CONFIG_DIR/tmux.conf.local" ]; then
    print_color "$GREEN" "Copying default .tmux.conf.local for customizations..."
    cp "$OHMYTMUX_INSTALL/.tmux.conf.local" "$TMUX_XDG_CONFIG_DIR/tmux.conf.local"
else
    print_color "$GREEN" ".tmux.conf.local already exists in XDG config. Skipping copy."
fi

print_color "$GREEN" "tmux and Oh My Tmux installation complete."