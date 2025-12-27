#!/bin/bash

# Script to install the FiraCode Nerd Font.
# This corresponds to the "System" -> "Fonts" category.

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of FiraCode Nerd Font"

FONT_NAME="FiraCode"
FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
FONT_ARCHIVE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
TEMP_DIR=$(mktemp -d)

# 1. Check if font is already installed (basic check)
if [ -d "$FONT_DIR" ] && [ "$(ls -A "$FONT_DIR")" ]; then
    print_color "$GREEN" "FiraCode Nerd Font appears to be already installed at $FONT_DIR. Skipping installation."
else
    print_color "$GREEN" "FiraCode Nerd Font not found or not fully installed. Proceeding with installation."
    # 2. Create the font directory if it doesn't exist
    print_color "$GREEN" "Creating font directory at $FONT_DIR..."
    mkdir -p "$FONT_DIR"

    # 3. Download and unzip the font
    print_color "$GREEN" "Downloading and unzipping FiraCode Nerd Font..."
    wget -q "$FONT_ARCHIVE_URL" -O "$TEMP_DIR/$FONT_NAME.zip"
    unzip -q "$TEMP_DIR/$FONT_NAME.zip" -d "$FONT_DIR"

    # 4. Clean up temporary files
    rm -rf "$TEMP_DIR"

    # 5. Refresh the font cache
    print_color "$GREEN" "Refreshing font cache..."
    fc-cache -f -v
fi

print_color "$GREEN" "FiraCode Nerd Font installation complete."