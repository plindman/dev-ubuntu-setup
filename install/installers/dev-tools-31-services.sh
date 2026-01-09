#!/bin/bash

# Script to install Docker Engine & CLI.
# This corresponds to the "Development Tools (CLI)" -> "Services" category in SOFTWARE_INDEX.md.

APP_NAME="Docker"
APP_COMMAND="docker"

install_docker() {
    # Install Docker Engine & CLI (adapted from official method)
    # https://www.tech2geek.net/install-docker-on-ubuntu-complete-step-by-step-guide/

    # Remove old/conflicting packages
    # Verbatim command from official Docker documentation
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt-get -qq remove "$pkg" || true
    done

    # Add Docker's official GPG key and Repository:
    # Verbatim repo string logic from official Docker documentation
    local docker_repo="https://download.docker.com/linux/ubuntu"
    local os_codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
    
    add_apt_repo "docker" \
        "https://download.docker.com/linux/ubuntu/gpg" \
        "[arch=$(dpkg --print-architecture)] $docker_repo $os_codename stable"

    # Install Docker packages
    quiet_apt_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add current user to docker group
    local current_user=$(id -u -n)
    sudo groupadd docker || true
    sudo usermod -aG docker "$current_user"
}

# Source shared installation helper
