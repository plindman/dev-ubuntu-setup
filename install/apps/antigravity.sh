#!/bin/bash

# Script to install Google Antigravity (AI-first IDE).
# This corresponds to the "Applications (GUI)" -> "Development" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Google Antigravity"

# Install Antigravity via official repository method
# Verbatim commands from official Google Antigravity documentation
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
    sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
    sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null

# Update after adding new repository
sudo apt update
sudo apt install antigravity -y

print_color "$GREEN" "Antigravity installation complete."
