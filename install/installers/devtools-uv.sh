#!/bin/bash

# Script to install uv.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

print_header "Starting installation of uv"

# Install uv via its official script
if ! command -v uv &> /dev/null; then
    print_color "$GREEN" "Installing uv into $HOME/.local/bin/..."
    # UV installer defaults to ~/.local/bin if XDG_BIN_HOME/XDG_DATA_HOME are not set.
    # UV_NO_MODIFY_PATH=1 prevents the installer from touching shell profiles.
    UV_NO_MODIFY_PATH=1 curl -LsSf https://astral.sh/uv/install.sh | sh

    # For the current session, ensure .local/bin is in PATH for verification.
    export PATH="$HOME/.local/bin:$PATH"
else
    print_color "$GREEN" "uv is already installed. Skipping."
fi

# Verify uv installation
if command -v uv &> /dev/null; then
    print_color "$GREEN" "uv installed successfully. Version: $(uv -V)"
else
    print_color "$RED" "uv installation failed."
    exit 1
fi

print_color "$GREEN" "uv installation complete."
