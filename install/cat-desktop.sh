#!/bin/bash

# This script orchestrates the installation of all components in the 'desktop' category.
# The order of execution is important to handle dependencies.

set -e

# Set repository root
if [[ -z "${REPO_ROOT:-}" ]]; then
    REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Source the helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

install_desktop() {
    print_header "Running Desktop Installation Scripts"

    # Install core desktop components
    install_and_show_versions gnome-tweaks gnome-shell-extension-manager
    install_and_show_versions libsecret-tools gnome-keyring

    # Install desktop utilities
    install_and_show_versions nemo synaptic

    print_color "$GREEN" "--- Desktop Installation Complete ---"
}

# If script is run directly (not sourced), execute the function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_desktop
fi
