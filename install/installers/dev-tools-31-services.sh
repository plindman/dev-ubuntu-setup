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

    # Add Docker's official GPG key:
    install_and_show_versions ca-certificates curl gnupg lsb-release
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-
$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update apt-get cache after adding the new repository
    sudo apt-get -qq update

    # Install Docker packages
    install_and_show_versions docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add current user to docker group
    local current_user=$(id -u -n)
    sudo groupadd docker || true
    sudo usermod -aG docker "$current_user"
}

# Source shared installation helper
