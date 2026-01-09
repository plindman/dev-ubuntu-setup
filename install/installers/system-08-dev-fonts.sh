#!/bin/bash

# Script to install Nerd Fonts (FiraCode and JetBrainsMono).
# Pre-requisites: system-01-core.sh (for unzip, fontconfig).
# This corresponds to the "System" -> "Fonts" category.

APP_NAME="Nerd Fonts (FiraCode, JetBrainsMono)"
FONTS=("FiraCode" "JetBrainsMono")

install_fonts() {
    local base_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1"
    local needs_refresh=false

    for font in "${FONTS[@]}"; do
        if font_zip_install "$font" "$base_url/$font.zip"; then
            needs_refresh=true
        fi
    done

    if [ "$needs_refresh" = true ]; then
        print_info "Refreshing font cache..."
        fc-cache -f > /dev/null
    fi
}

verify_fonts() {
    fonts_installed "${FONTS[@]}"
}

verify_details_fonts() {
    print_missing_fonts "${FONTS[@]}"
}
