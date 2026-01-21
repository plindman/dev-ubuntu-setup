#!/bin/bash
APP_NAME="Core System Utilities"
# APP_COMMAND not relevant given we have the verify functions. it is either or.
# APP_COMMAND=("unzip" "gpg" "lsb_release" "shellcheck")

# Convenience list for verification
CORE_PACKAGES=(
    # Repository & package management essentials
    "apt-transport-https"    # Required for apt to access HTTPS repositories (third-party repos)
    "ca-certificates"         # SSL/TLS certificates for secure connections (curl, wget)
    "gnupg"                   # GPG for verifying apt repository signatures
    "software-properties-common"  # Provides add-apt-repository command
    "apt-utils"               # Improves apt output (prevents debconf warnings)

    # Archive & file utilities
    "unzip"                   # Required to extract downloaded zip files (fonts, etc.)

    # System information
    "lsb-release"             # Provides OS version info (used by external install scripts)

    # Font management (needed early by system-03-console-fonts.sh)
    "fontconfig"              # Font configuration and caching

    # Security utilities
    "age"                     # File encryption (used by chezmoi for dotfiles)
    "shellcheck"              # Shell script linting (validates downloaded install scripts)
)

install_core() {
    # Install apt-utils first to avoid debconf warnings
    sudo apt-get -qq install -y apt-utils > /dev/null 2>&1

    # Install essential core packages first (includes apt-utils to silence warnings)
    quiet_apt_update && quiet_apt_install "${CORE_PACKAGES[@]}"

    print_color "$GREEN" "Disabling Ubuntu Pro promotional messages..."
    export TERM=linux
    export DEBIAN_FRONTEND=noninteractive
    export DEBCONF_NONINTERACTIVE_SEEN=true

    # 1. Kill the apt-get hook that adds the "Pro" messages to your terminal
    if [ -f /etc/apt/apt.conf.d/20apt-esm-hook.conf ]; then
        sudo chmod -x /etc/apt/apt.conf.d/20apt-esm-hook.conf 2>/dev/null || true
        sudo sed -i 's/^/#/' /etc/apt/apt.conf.d/20apt-esm-hook.conf 2>/dev/null || true
    fi

    # 2. Tell the 'pro' tool itself to stop showing news
    sudo pro config set apt_news=false >/dev/null 2>&1 || true

    # 3. Disable the MOTD news (the "Get Ubuntu Pro" login messages)
    if [ -f /etc/default/motd-news ]; then
        sudo sed -i 's/ENABLED=1/ENABLED=0/' /etc/default/motd-news 2>/dev/null || true
    fi

    # 4. Remove the symlinks that trigger the Pro advertisements in the terminal
    sudo rm -f /etc/apt/apt.conf.d/20ubuntu-advantage-tools 2>/dev/null || true

    # Upgrade system packages
    sudo apt-get -qq upgrade -y > /dev/null
}

verify_core() {
    for pkg in "${CORE_PACKAGES[@]}"; do
        if ! package_installed "$pkg"; then
            return 1
        fi
    done
    return 0
}

verify_details_core() {
    local missing=()
    for pkg in "${CORE_PACKAGES[@]}"; do
        if ! package_installed "$pkg"; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}
