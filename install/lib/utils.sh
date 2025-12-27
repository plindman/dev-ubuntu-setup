#!/bin/bash
#
# Utility functions for common checks.

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
