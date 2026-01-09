#!/bin/bash

# Script to install Professional Writing Fonts.
# Includes: Inter, EB Garamond, Libertinus (via GitHub) 
# and IBM Plex, Noto, TeX Gyre, etc. (via apt).
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

install_writing_fonts() {
    # Ensure fontconfig is installed for fc-list/fc-cache
    install_and_show_versions fontconfig

    # 1. Install apt-based fonts
    print_info "Installing professional fonts via apt..."
    install_and_show_versions "${APT_FONTS[@]}"

    # 2. Install manual fonts
    local temp_dir=""
    local cache_needs_update=false

    for font_entry in "${WRITING_FONTS[@]}"; do
        local font_name="${font_entry%%|*}"
        local font_url="${font_entry#*|}"
        local font_dir="$HOME/.local/share/fonts/$font_name"

        # Check if files exist on disk
        if [[ -d "$font_dir" ]] && [[ -n "$(ls -A "$font_dir" 2>/dev/null)" ]]; then
            # Files exist. Check if system knows about them.
            if fc-list : family | grep -qi "$font_name"; then
                print_color "$GREEN" "$font_name is already installed and registered. Skipping."
                continue
            else
                print_warning "$font_name files exist but not registered in system. Will refresh cache."
                cache_needs_update=true
                continue
            fi
        fi

        # Create temp dir only if we actually need to install something
        if [[ -z "$temp_dir" ]]; then
            temp_dir=$(mktemp -d)
        fi

        print_info "Installing $font_name..."
        
        # Ensure target directory exists
        mkdir -p "$font_dir"

        # Download
        local zip_file="$temp_dir/$font_name.zip"
        if wget -q --show-progress "$font_url" -O "$zip_file"; then
             # Unzip flattening directory structure (-j), overwriting (-o), only font files
             # We look for .ttf and .otf. Some zips might have one or the other.
             if unzip -oj "$zip_file" "*.ttf" "*.otf" -d "$font_dir" > /dev/null 2>&1; then
                print_color "$GREEN" "Successfully downloaded and extracted $font_name."
                cache_needs_update=true
             else
                print_error "Failed to extract fonts from $zip_file"
             fi
        else
             print_error "Failed to download $font_name from $font_url"
        fi
    done

    # Clean up if temp dir was created
    if [[ -n "$temp_dir" ]]; then
        rm -rf "$temp_dir"
    fi

    # Refresh cache only if new fonts were installed or need registration
    if $cache_needs_update; then
        print_info "Refreshing font cache..."
        fc-cache -f -v > /dev/null
    fi
}

verify_writing_fonts() {
    # Check apt packages
    for pkg in "${APT_FONTS[@]}"; do
        if ! package_installed "$pkg"; then
            return 1
        fi
    done

    # Check manual fonts
    for font_entry in "${WRITING_FONTS[@]}"; do
        local font_name="${font_entry%%|*}"
        if ! fc-list : family | grep -qi "$font_name"; then
            return 1
        fi
    done
    
    return 0
}

verify_details_writing_fonts() {
    local missing=()
    
    # Check apt packages
    for pkg in "${APT_FONTS[@]}"; do
        if ! package_installed "$pkg"; then
            missing+=("$pkg (apt)")
        fi
    done

    # Check manual fonts
    for font_entry in "${WRITING_FONTS[@]}"; do
        local font_name="${font_entry%%|*}"
        if ! fc-list : family | grep -qi "$font_name"; then
            missing+=("$font_name")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}
