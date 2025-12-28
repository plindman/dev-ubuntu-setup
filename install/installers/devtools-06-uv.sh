#!/bin/bash

# Script to install uv.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="uv"
APP_COMMAND="uv"

install_uv() {
    # Install uv via its official script
    # UV installer defaults to ~/.local/bin if XDG_BIN_HOME/XDG_DATA_HOME are not set.
    # UV_NO_MODIFY_PATH=1 prevents the installer from touching shell profiles.
    UV_NO_MODIFY_PATH=1 curl -LsSf https://astral.sh/uv/install.sh | sh
}

# Source shared installation helper
