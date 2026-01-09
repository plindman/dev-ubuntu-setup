#!/bin/bash
#
# Utility functions for common checks and package management.

source "$(dirname "${BASH_SOURCE[0]}")/output.sh"

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

# Function to update apt cache quietly.
quiet_apt_update() {
    sudo apt-get -qq update > /dev/null
}

# --- Package Management ---

# Function to install apt packages silently and show their versions.
# Returns 0 on success, 1 on failure.
quiet_apt_install() {
    local packages=("$@")
    print_color "$GREEN" "Installing/Upgrading apt packages: ${packages[*]}..."

    if sudo apt-get -qq install -y "${packages[@]}" > /dev/null; then
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

# Helper to add a third-party APT repository quietly.
# Usage: add_apt_repo "name" "gpg_url" "repo_url"
add_apt_repo() {
    local name="$1"
    local gpg_url="$2"
    local repo_line="$3"
    
    print_info "Adding repository: $name..."
    
    # 1. Ensure keyring directory exists
    sudo mkdir -p -m 755 /etc/apt/keyrings
    
    # 2. Download and dearmor GPG key
    # We use a temp file to avoid piping directly to gpg which can be brittle
    local tmp_key=$(mktemp)
    if curl -fsSL "$gpg_url" -o "$tmp_key"; then
        cat "$tmp_key" | sudo gpg --dearmor --yes -o "/usr/share/keyrings/${name}.gpg"
        sudo chmod go+r "/usr/share/keyrings/${name}.gpg"
        rm "$tmp_key"
    else
        print_error "Failed to download GPG key for $name"
        return 1
    fi
    
    # 3. Add the repo line
    # We use the signed-by field for better security
    local finalized_repo_line="${repo_line/\]/ signed-by=\/usr\/share\/keyrings\/${name}.gpg\]}"
    # If the line didn't have brackets at all, we handle it
    if [[ "$finalized_repo_line" == "$repo_line" ]]; then
        finalized_repo_line="deb [signed-by=/usr/share/keyrings/${name}.gpg] $repo_line"
    fi
    
    echo "$finalized_repo_line" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
    
    # 4. Update apt cache for this repo
    quiet_apt_update
}