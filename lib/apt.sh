#!/bin/bash
#
# APT package management utilities.

# Function to update apt cache quietly.
quiet_apt_update() {
    sudo apt-get -qq update > /dev/null
}

# Function to install apt packages silently and show their versions.
# Returns 0 on success, 1 on failure.
quiet_apt_install() {
    local packages=($@)
    print_color "$GREEN" "Installing/Upgrading apt packages: ${packages[*]}..."

    if sudo -E apt-get -qq install -y "${packages[@]}" > /dev/null; then
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

# Print versions of a list of apt packages.
# Usage: print_apt_package_versions "pkg1" "pkg2"
print_apt_package_versions() {
    local packages=("$@")
    dpkg-query -W -f='  ${Package}: ${Version}\n' "${packages[@]}" 2>/dev/null || true
}
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
    local finalized_repo_line="$repo_line"
    if [[ "${finalized_repo_line:0:4}" != "deb " ]]; then
        finalized_repo_line="deb $finalized_repo_line"
    fi

    if [[ "$finalized_repo_line" == *"]"* ]]; then
        finalized_repo_line="${finalized_repo_line/]/ signed-by=\/usr\/share\/keyrings\/${name}.gpg]}"
    else
        finalized_repo_line="${finalized_repo_line/deb /deb [signed-by=\/usr\/share\/keyrings\/${name}.gpg] }"
    fi
    
    echo "$finalized_repo_line" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
    
    # 4. Update apt cache for this repo
    quiet_apt_update
}
