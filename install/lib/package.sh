#!/bin/bash
#
# Package management functions.

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
