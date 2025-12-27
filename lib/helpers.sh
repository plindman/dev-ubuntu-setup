#!/bin/bash
#
# Helper functions for colored output and package management in installation scripts.
# Source this file after setting REPO_ROOT in your script.

# --- Color codes ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Output Functions ---

# Print colored output
print_color() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Print a section header
print_header() {
    print_color "$BLUE" "\n=== $1 ==="
}

# Print info message
print_info() {
    print_color "$BLUE" "INFO: $1"
}

# Print success message
print_success() {
    print_color "$GREEN" "SUCCESS: $1"
}

# Print warning message
print_warning() {
    print_color "$YELLOW" "WARNING: $1"
}

# Print error message
print_error() {
    print_color "$RED" "ERROR: $1" >&2
}

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
        print_color "$RED" "Error: Failed to install/upgrade apt packages: ${packages[*]}."
        return 1
    fi
}

# --- Script Execution ---

# Helper function to run a script if it exists
# Usage: run_script "$REPO_ROOT/install/system/core.sh"
run_script() {
    local script_path="$1"
    if [ -f "$script_path" ]; then
        bash "$script_path"
    else
        print_warning "Script not found at $script_path. Skipping."
    fi
}
