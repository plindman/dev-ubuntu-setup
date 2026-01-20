#!/bin/bash

# Script to install Bun.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="Bun"
APP_COMMAND="bun"

install_bun() {
    # Install Bun via its official script, respecting BUN_INSTALL for XDG compliance
    local script
    script=$(download_and_validate_script "https://bun.sh/install") || return 1
    BUN_INSTALL="$HOME/.local" bash "$script" > /dev/null 2>&1
    rm -f "$script"

    # Export both potential locations for current session verification
    export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
}

# Source shared installation helper
