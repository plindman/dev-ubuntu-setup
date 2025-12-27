#!/bin/bash

# Script to install the FiraCode Nerd Font.
# This corresponds to the "System" -> "Fonts" category.

APP_NAME="FiraCode Nerd Font"
# No APP_COMMAND - font installer

install_fonts() {
    FONT_NAME="FiraCode"
    FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
    FONT_ARCHIVE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
    TEMP_DIR=$(mktemp -d)

    # Create the font directory if it doesn't exist
    mkdir -p "$FONT_DIR"

    # Download and unzip the font
    wget -q "$FONT_ARCHIVE_URL" -O "$TEMP_DIR/$FONT_NAME.zip"
    unzip -q "$TEMP_DIR/$FONT_NAME.zip" -d "$FONT_DIR"

    # Clean up temporary files
    rm -rf "$TEMP_DIR"

    # Refresh the font cache
    fc-cache -f -v
}

# Source shared installation helper
source "$(dirname "$0")/../lib/install_app.sh"
