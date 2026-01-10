#!/bin/bash

# Script to install Nerd Fonts (FiraCode and JetBrainsMono).
# Pre-requisites: system-01-core.sh (for unzip, fontconfig).
# This corresponds to the "System" -> "Fonts" category.

APP_NAME="Nerd Fonts (FiraCode, JetBrainsMono)"

# Define fonts: "Name|URL"
NERD_FONTS=(
    "FiraCode|https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
    "JetBrainsMono|https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
)

# Convenience list for verification
FONT_NAMES=("FiraCode" "JetBrainsMono")

install_fonts() {
    quiet_font_install "${NERD_FONTS[@]}"
}

verify_fonts() {
    fonts_installed "${FONT_NAMES[@]}"
}

verify_details_fonts() {
    print_missing_fonts "${FONT_NAMES[@]}"
}