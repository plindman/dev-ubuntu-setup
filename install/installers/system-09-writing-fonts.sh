#!/bin/bash

# Script to install Professional Writing Fonts.
# Pre-requisites: system-01-core.sh (for unzip, fontconfig).
# This corresponds to the "System" -> "Writing Fonts" category.

APP_NAME="Writing Fonts (Inter, IBM Plex, Garamond, etc.)"

# Apt packages for professional typography
APT_FONTS=(
    "fonts-ibm-plex"
    "fonts-noto"
    "fonts-texgyre"
    "fonts-lmodern"
    "fonts-dejavu"
)

# Manual fonts: "Name|URL"
WRITING_FONTS=(
    "Inter|https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip"
    "EB Garamond|https://github.com/georgd/EB-Garamond/releases/download/nightly/EBGaramond.zip"
    "Libertinus|https://github.com/alerque/libertinus/releases/download/v7.051/Libertinus-7.051.zip"
)

# Convenience list for verification
MANUAL_FONT_NAMES=("Inter" "EB Garamond" "Libertinus")

install_writing_fonts() {
    # 1. Install apt-based fonts
    print_info "Installing professional fonts via apt..."
    quiet_apt_install "${APT_FONTS[@]}"

    # 2. Install manual fonts
    local needs_refresh=false

    for font_entry in "${WRITING_FONTS[@]}"; do
        local font_name="${font_entry%%|*}"
        local font_url="${font_entry#*|}"
        
        if font_zip_install "$font_name" "$font_url"; then
            needs_refresh=true
        fi
    done

    if [ "$needs_refresh" = true ]; then
        print_info "Refreshing font cache..."
        fc-cache -f > /dev/null
    fi
}

verify_writing_fonts() {
    # Check apt packages
    for pkg in "${APT_FONTS[@]}"; do
        if ! package_installed "$pkg"; then
            return 1
        fi
    done

    # Check manual fonts using utility
    fonts_installed "${MANUAL_FONT_NAMES[@]}"
}

verify_details_writing_fonts() {
    local missing_pkgs=()
    for pkg in "${APT_FONTS[@]}"; do
        if ! package_installed "$pkg"; then
            missing_pkgs+=("$pkg (apt)")
        fi
    done

    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing_pkgs[*]}"
    fi

    # Check manual fonts using utility
    print_missing_fonts "${MANUAL_FONT_NAMES[@]}"
}