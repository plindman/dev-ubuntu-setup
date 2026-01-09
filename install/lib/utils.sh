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
    local packages=($@)
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
    # Ensure it starts with 'deb '
    local finalized_repo_line="$repo_line"
    if [[ "${finalized_repo_line:0:4}" != "deb " ]]; then
        finalized_repo_line="deb $finalized_repo_line"
    fi

    # Inject signed-by field
    if [[ "$finalized_repo_line" == *"]"* ]]; then
        # Add inside existing brackets
        finalized_repo_line="${finalized_repo_line/]/ signed-by=\/usr\/share\/keyrings\/${name}.gpg]}"
    else
        # Add new brackets after 'deb '
        finalized_repo_line="${finalized_repo_line/deb /deb [signed-by=\/usr\/share\/keyrings\/${name}.gpg] }"
    fi
    
    echo "$finalized_repo_line" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
    
    # 4. Update apt cache for this repo
    quiet_apt_update
}

# --- Font Utilities ---

# Verify if a list of font families are installed and registered in the system.
# Usage: fonts_installed "FiraCode" "JetBrainsMono"
fonts_installed() {
    for font in "$@"; do
        if ! fc-list : family | grep -qi "$font"; then
            return 1
        fi
    done
    return 0
}

# Print missing fonts from a provided list.
# Usage: print_missing_fonts "FiraCode" "JetBrainsMono"
print_missing_fonts() {
    local missing=()
    for font in "$@"; do
        if ! fc-list : family | grep -qi "$font"; then
            missing+=("$font")
        fi
    done
    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}

# Install a font from a ZIP URL to ~/.local/share/fonts.
# Does NOT refresh cache automatically (caller should do it once at the end).
# Returns 0 if installed/already present, 1 on failure.
# Usage: font_zip_install "FontName" "https://url/to/font.zip"
font_zip_install() {
    local name="$1"
    local url="$2"
    local font_dir="$HOME/.local/share/fonts/$name"

    # Skip if already exists on disk AND registered in system
    if [[ -d "$font_dir" ]] && [[ -n "$(ls -A "$font_dir" 2>/dev/null)" ]]; then
        if fc-list : family | grep -qi "$name"; then
            return 0
        fi
    fi

    print_info "Installing $name..."
    mkdir -p "$font_dir"
    local tmp_zip=$(mktemp)
    if wget -q "$url" -O "$tmp_zip"; then
        # -j: flatten, -o: overwrite, filter for common font extensions
        unzip -oj "$tmp_zip" "*.ttf" "*.otf" "*.ttc" -d "$font_dir" > /dev/null 2>&1
        rm "$tmp_zip"
        return 0
    else
        print_error "Failed to download $name from $url"
        return 1
    fi
}