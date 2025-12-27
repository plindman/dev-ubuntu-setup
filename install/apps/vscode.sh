#!/bin/bash

# Script to install Visual Studio Code.
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.
# https://code.visualstudio.com/docs/setup/linux
# https://itsfoss.gitlab.io/post/how-to-install-vscode-on-ubuntu-2404-2204-or-2004/

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Visual Studio Code"

# Install VS Code via official repository method
# Verbatim commands from official VS Code documentation
sudo apt install software-properties-common -y
sudo apt-add-repository "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main"

# Update after adding new repository
sudo apt update
sudo apt install code -y

print_color "$GREEN" "Visual Studio Code installation complete."
