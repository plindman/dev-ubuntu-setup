#!/bin/bash
#
# Utility functions for common checks and package management.

source "$(dirname "${BASH_SOURCE[0]}")"/output.sh"

# Add ~/.local/bin to PATH for command_exists checks during installation
# This is temporary - only for the duration of the install script
export PATH="$HOME/.local/bin:$PATH"

# --- Utility Functions ---

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running as root
is_root() {
    [[ $EUID -eq 0 ]]
}

# Check if a package is installed
package_installed() {
    dpkg -l "$1" &> /dev/null
}
