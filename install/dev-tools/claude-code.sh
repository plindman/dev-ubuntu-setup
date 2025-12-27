#!/bin/bash

# Script to install Claude Code.
# This corresponds to the "Development Tools (CLI)" -> "AI & LLM Tools" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Claude Code"

# Install Claude Code via its official script
# https://code.claude.com/docs/en/setup
if ! command -v claude &> /dev/null; then
    print_color "$GREEN" "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    # The installation script should handle PATH.
else
    print_color "$GREEN" "Claude Code is already installed. Skipping."
fi

# Verify Claude Code installation
if command -v claude &> /dev/null; then
    print_color "$GREEN" "Claude Code installed successfully. Version: $(claude -v)"
else
    print_color "$YELLOW" "Warning: 'claude' command not found in PATH after installation. Manual verification might be needed."
fi

print_color "$GREEN" "Claude Code installation complete."
