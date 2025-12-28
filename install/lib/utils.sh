#!/bin/bash
#
# Utility functions for common checks and package management.

source "$(dirname "${BASH_SOURCE[0]}")/output.sh"

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

# --- Package Management ---

# Function to install apt packages silently and show their versions.
# Returns 0 on success, 1 on failure.
install_and_show_versions() {
    local packages=("$@")
    print_color "$GREEN" "Installing/Upgrading apt packages: ${packages[*]}..."

    if sudo apt-get -qq install -y "${packages[@]}"; then
        print_color "$GREEN" "Successfully installed/upgraded packages."
        print_color "$GREEN" "Installed Versions:"
        dpkg-query -W -f='  ${Package}: ${Version}\n' "${packages[@]}" 2>/dev/null || \
            print_color "$YELLOW" "Warning: Could not query versions for all packages."
        return 0
    else
        print_color "$RED" "Error: Failed to install/upgrade apt packages: ${packages[*]}..."
        return 1
    fi
}