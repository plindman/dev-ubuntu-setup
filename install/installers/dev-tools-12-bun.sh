#!/bin/bash

# Script to install Bun.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="Bun"
APP_COMMAND="bun"

install_bun() {
    # Install Bun via its official script, respecting BUN_INSTALL for XDG compliance
    BUN_INSTALL="$HOME/.local" curl -fsSL https://bun.sh/install | bash
}

# Source shared installation helper
