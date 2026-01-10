#!/bin/bash
APP_NAME="Core System Utilities"
APP_COMMAND=("unzip" "gpg" "lsb_release")

# Convenience list for verification
CORE_PACKAGES=(
    "apt-transport-https"
    "ca-certificates"
    "gnupg"
    "lsb-release"
    "unzip"
    "software-properties-common"
    "fontconfig"
    "apt-utils"
)

install_core() {
    # Install apt-utils first to avoid debconf warnings
    quiet_apt_update && quiet_apt_install apt-utils

    # Upgrade system packages
    print_color "$GREEN" "Disabling Ubuntu Pro promotional messages..."
    export DEBIAN_FRONTEND=noninteractive
    export DEBCONF_NONINTERACTIVE_SEEN=true

    for service in esm-apps esm-infra livepatch uc; do
        sudo -E pro disable "$service" >/dev/null 2>&1 </dev/null || true
    done

    sudo apt-get -qq upgrade -y > /dev/null

    # Install essential core packages
    quiet_apt_install "${CORE_PACKAGES[@]}"
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
