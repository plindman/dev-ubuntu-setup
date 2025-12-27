#!/bin/bash

# Script to install tmux and Oh My Tmux.
# This corresponds to the "System" -> "Shell" category in SOFTWARE_INDEX.md.

APP_NAME="tmux and Oh My Tmux"
APP_COMMAND="tmux"

install_tmux() {
    install_and_show_versions tmux

    # Oh My Tmux
    # Framework is cloned into $HOME/.local/share/oh-my-tmux (XDG compliant)
    OHMYTMUX_INSTALL="$HOME/.local/share/oh-my-tmux"
    XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    TMUX_XDG_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"

    # Check for legacy non-XDG installation
    if [ -d "$HOME/.tmux" ] && [ "$HOME/.tmux" != "$OHMYTMUX_INSTALL" ]; then
        print_color "$YELLOW" "Warning: Legacy installation at ~/.tmux found. Using XDG path instead."
    fi

    if [ ! -d "$OHMYTMUX_INSTALL" ]; then
        git clone --single-branch https://github.com/gpakosz/.tmux.git "$OHMYTMUX_INSTALL"
    else
        if [ -d "$OHMYTMUX_INSTALL/.git" ]; then
            (cd "$OHMYTMUX_INSTALL" && git pull)
        fi
    fi

    # Create XDG compliant config directory
    mkdir -p "$TMUX_XDG_CONFIG_DIR"

    # Symlink main .tmux.conf from repository
    if [ ! -f "$TMUX_XDG_CONFIG_DIR/tmux.conf" ]; then
        ln -s "$OHMYTMUX_INSTALL/.tmux.conf" "$TMUX_XDG_CONFIG_DIR/tmux.conf"
    fi

    # Copy local customizations file
    if [ ! -f "$TMUX_XDG_CONFIG_DIR/tmux.conf.local" ]; then
        cp "$OHMYTMUX_INSTALL/.tmux.conf.local" "$TMUX_XDG_CONFIG_DIR/tmux.conf.local"
    fi
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
