#!/bin/bash
APP_NAME="Core System Utilities"
APP_COMMAND=("unzip" "gpg" "lsb_release")

install_core() {
    # Install apt-utils first to avoid debconf warnings
    quiet_apt_update && quiet_apt_install apt-utils

    # Upgrade system packages
    print_color "$GREEN" "Disabling Ubuntu Pro promotional messages..."
    sudo pro disable esm-apps > /dev/null 2>&1 || true
    sudo pro disable esm-infra > /dev/null 2>&1 || true
    sudo pro disable livepatch > /dev/null 2>&1 || true
    sudo pro disable uc > /dev/null 2>&1 || true

    sudo apt-get -qq upgrade -y > /dev/null

    # Install essential core packages
    quiet_apt_install apt-transport-https ca-certificates gnupg lsb-release unzip software-properties-common fontconfig
}
