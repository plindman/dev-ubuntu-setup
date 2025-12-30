#!/bin/bash

# Script to install Nerd Fonts (FiraCode and JetBrainsMono).
# This corresponds to the "System" -> "Fonts" category.

APP_NAME="Nerd Fonts (FiraCode, JetBrainsMono)"
APP_COMMAND="fc-cache"
FONTS=("FiraCode" "JetBrainsMono")

install_fonts() {
    local base_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1"
    local temp_dir=""
    local cache_needs_update=false

    for font in "${FONTS[@]}"; do
        local font_dir="$HOME/.local/share/fonts/$font"
        
        # Check if files exist on disk
        if [[ -d "$font_dir" ]] && [[ -n "$(ls -A $font_dir)" ]]; then
            # Files exist. Check if system knows about them.
            if fc-list : family | grep -qi "$font"; then
                print_color "$GREEN" "$font is already installed and registered. Skipping."
                continue
            else
                print_warning "$font files exist but not registered in system. Will refresh cache."
                cache_needs_update=true
                continue
            fi
        fi

        # Create temp dir only if we actually need to install something
        if [[ -z "$temp_dir" ]]; then
            temp_dir=$(mktemp -d)
        fi

        print_info "Installing $font..."
        local url="$base_url/$font.zip"

        mkdir -p "$font_dir"
        wget -q "$url" -O "$temp_dir/$font.zip"
        unzip -qo "$temp_dir/$font.zip" -d "$font_dir"
        cache_needs_update=true
    done

    # Clean up if temp dir was created
    if [[ -n "$temp_dir" ]]; then
        rm -rf "$temp_dir"
    fi

    # Refresh cache only if new fonts were installed or need registration
    if $cache_needs_update; then
        print_info "Refreshing font cache..."
        fc-cache -f -v
    fi
}

verify_fonts() {
    # Update cache to ensure we see installed fonts
    fc-cache -f >/dev/null 2>&1

    for font in "${FONTS[@]}"; do
        if ! fc-list : family | grep -qi "$font"; then
            return 1
        fi
    done
    return 0
}

verify_details_fonts() {
    local missing=()
    
    for font in "${FONTS[@]}"; do
        if ! fc-list : family | grep -qi "$font"; then
            missing+=("$font")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}