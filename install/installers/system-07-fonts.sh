#!/bin/bash

# Script to install Nerd Fonts (FiraCode and JetBrainsMono).
# This corresponds to the "System" -> "Fonts" category.

APP_NAME="Nerd Fonts (FiraCode, JetBrainsMono)"
APP_COMMAND="fc-cache"

install_fonts() {
    local fonts=("FiraCode" "JetBrainsMono")
    local base_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1"
    local temp_dir=$(mktemp -d)

    for font in "${fonts[@]}"; do
        print_info "Installing $font..."
        local font_dir="$HOME/.local/share/fonts/$font"
        local url="$base_url/$font.zip"

        mkdir -p "$font_dir"
        wget -q "$url" -O "$temp_dir/$font.zip"
        unzip -q "$temp_dir/$font.zip" -d "$font_dir"
    done

    # Clean up
    rm -rf "$temp_dir"

    # Refresh cache
    fc-cache -f -v
}

verify_fonts() {
    # Check for FiraCode and JetBrainsMono silently
    fc-list : family | grep -qi "FiraCode" && fc-list : family | grep -qi "JetBrainsMono"
}

verify_details_fonts() {
    local missing=()
    
    # Check for FiraCode
    if ! fc-list : family | grep -qi "FiraCode"; then
        missing+=("FiraCode")
    fi
    
    # Check for JetBrainsMono
    if ! fc-list : family | grep -qi "JetBrainsMono"; then
        missing+=("JetBrainsMono")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}