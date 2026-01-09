#!/bin/bash

# Script to install Bun.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="Bun"
APP_COMMAND="bun"

install_bun() {
    # Install Bun via its official script, respecting BUN_INSTALL for XDG compliance
    # We pass it directly to bash to ensure it is picked up
    curl -fsSL https://bun.sh/install | BUN_INSTALL="$HOME/.local" bash

    # Export both potential locations for current session verification
    export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
}

# Source shared installation helper
