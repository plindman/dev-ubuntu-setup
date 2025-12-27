#!/bin/bash

# Script to install Git and GitHub CLI.
# This corresponds to the "Development Tools (CLI)" -> "Git" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Git and GitHub CLI"

# 1. Install git-all
install_and_show_versions git-all

# 2. Install gh (GitHub CLI)
# Following the verbatim command provided by the user.
print_color "$GREEN" "Installing GitHub CLI (gh) using verbatim official method..."

(type -p wget >/dev/null || (sudo apt-get -qq update && sudo apt-get -q install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt-get -qq update \
	&& sudo apt-get -q install gh -y

print_color "$GREEN" "Git and GitHub CLI installation complete."

