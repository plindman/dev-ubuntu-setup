#!/bin/bash

# Script to install Gemini CLI.
# This corresponds to the "Development Tools (CLI)" -> "AI & LLM Tools" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

print_header "Starting installation of Gemini CLI"

# Install Gemini CLI via npm
# This assumes Node.js and npm are already installed (handled by nodejs.sh).
if ! command -v gemini &> /dev/null; then
    print_color "$GREEN" "Installing Gemini CLI via npm..."
    # npm install -g installs to a global location, usually /usr/local/bin or ~/.npm-global/bin
    # This should already be in PATH.
    npm install -g @google/gemini-cli
else
    print_color "$GREEN" "Gemini CLI is already installed. Skipping."
fi

# Verify Gemini CLI installation
if command -v gemini &> /dev/null; then
    print_color "$GREEN" "Gemini CLI installed successfully. Version: $(gemini --version)"
else
    print_color "$RED" "Gemini CLI installation failed or 'gemini' command not found."
    exit 1
fi

print_color "$GREEN" "Gemini CLI installation complete."
