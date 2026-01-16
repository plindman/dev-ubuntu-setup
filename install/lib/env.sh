#!/bin/bash

# XDG Base Directory Specification setup
# This file contains functions for setting up and managing XDG-compliant directory structures

# Setup standard XDG directories if they don't exist
# Creates all commonly used XDG Base Directory locations
# Based on: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
setup_xdg_dirs() {
    # XDG_BIN_DIR - User binaries (de facto standard, not in XDG spec)
    mkdir -p "$HOME/.local/bin"

    # XDG_DATA_HOME - Data files (default: $HOME/.local/share)
    mkdir -p "$HOME/.local/share"

    # XDG_CONFIG_HOME - Configuration files (default: $HOME/.config)
    mkdir -p "$HOME/.config"

    # XDG_STATE_HOME - State files (default: $HOME/.local/state)
    mkdir -p "$HOME/.local/state"

    # XDG_CACHE_HOME - Cache files (default: $HOME/.cache)
    mkdir -p "$HOME/.cache"
}
