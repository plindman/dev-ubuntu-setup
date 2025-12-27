#!/bin/bash

# Script to install Bun.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Bun"

# Install Bun via its official script, respecting BUN_INSTALL for XDG compliance
if ! command -v bun &> /dev/null; then
    print_color "$GREEN" "Installing Bun into $HOME/.local/bin/..."

    # Set BUN_INSTALL to target $HOME/.local, so bun installs to $HOME/.local/bin/bun
    BUN_INSTALL="$HOME/.local" curl -fsSL https://bun.sh/install | bash

    # For the current session, ensure .local/bin is in PATH for verification.
    export PATH="$HOME/.local/bin:$PATH"
else
    print_color "$GREEN" "Bun is already installed. Skipping."
fi

# Verify Bun installation
if command -v bun &> /dev/null; then
    print_color "$GREEN" "Bun installed successfully. Version: $(bun -v)"
else
    print_color "$RED" "Bun installation failed."
    exit 1
fi

print_color "$GREEN" "Bun installation complete."
