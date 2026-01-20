#!/bin/bash
#
# Core utility functions for common checks.

# Add ~/.local/bin and mise shims to PATH for command_exists checks during installation
# This is temporary - only for the duration of the install script
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

# --- Utility Functions ---

# Check if a command exists
command_exists() {
    type "$1" &> /dev/null
}

# Check if running as root
is_root() {
    [[ $EUID -eq 0 ]]
}

# Check if a package is installed
package_installed() {
    dpkg -l "$1" &> /dev/null
}

