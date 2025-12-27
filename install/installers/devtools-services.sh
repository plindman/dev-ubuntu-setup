#!/bin/bash

# Script to install Docker Engine & CLI and VS Code Server.
# This corresponds to the "Development Tools (CLI)" -> "Services" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Development Services"

# 1. Install Docker Engine & CLI (adapted from official method)
# https://www.tech2geek.net/install-docker-on-ubuntu-complete-step-by-step-guide/
print_color "$GREEN" "Installing Docker Engine & CLI..."

# Remove old/conflicting packages
# Verbatim command from official Docker documentation
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    print_color "$GREEN" "Removing old package: $pkg..."
    sudo apt-get -qq remove "$pkg" || true
done

# Add Docker's official GPG key:
print_color "$GREEN" "Adding Docker's official GPG key..."
install_and_show_versions ca-certificates curl gnupg lsb-release # Ensure these are present
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
print_color "$GREEN" "Adding Docker repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-
$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt-get cache after adding the new repository
# Necessary after adding a new apt repository
print_color "$GREEN" "Updating package lists after adding Docker repo..."
sudo apt-get -qq update

# Install Docker packages
install_and_show_versions docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
print_color "$GREEN" "Adding current user to docker group..."
sudo groupadd docker || true # Add group if it doesn't exist
sudo usermod -aG docker "${USER}"

# 2. Install VS Code Server
print_color "$GREEN" "Installing VS Code Server..."
print_color "$YELLOW" "Note: VS Code Server is installed on demand during remote connection via VS Code client."
print_color "$YELLOW" "This script does not perform a standalone VS Code Server installation."

print_color "$GREEN" "Development Services installation complete."
