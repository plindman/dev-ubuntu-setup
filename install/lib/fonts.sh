#!/bin/bash
#
# Font installation and verification utilities.

# Verify if a list of font families are installed and registered in the system.
# Usage: fonts_installed "FiraCode" "JetBrainsMono"
fonts_installed() {
    for font in "$@"; do
        if ! fc-list : family | grep -qi "$font"; then
            return 1
        fi
    done
    return 0
}

# Print missing fonts from a provided list.
# Usage: print_missing_fonts "FiraCode" "JetBrainsMono"
print_missing_fonts() {
    local missing=()
    for font in "$@"; do
        if ! fc-list : family | grep -qi "$font"; then
            missing+=("$font")
        fi
    done
    if [ ${#missing[@]} -gt 0 ]; then
        print_color "$YELLOW" "   Missing: ${missing[*]}"
    fi
}

# Print versions of installed manual fonts.
# Usage: print_font_versions "FontName1" "FontName2"
print_font_versions() {
    print_color "$GREEN" "Manual Font Versions:"
    for font in "$@"; do
        # Try exact family name first, then with "Nerd Font" suffix
        local version=$(fc-list ":family=$font" fontversion 2>/dev/null | head -n 1 | sed "s/^.*version=//;s/[: ]//g")
        
        if [ -z "$version" ]; then
            version=$(fc-list ":family=$font Nerd Font" fontversion 2>/dev/null | head -n 1 | sed "s/^.*version=//;s/[: ]//g")
        fi

        if [ -n "$version" ]; then
            echo "  $font: $version"
        else
            # Last ditch attempt: check for any version string if fontversion integer is missing
            version=$(fc-list ":family=$font" version 2>/dev/null | head -n 1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?')
            if [ -n "$version" ]; then
                echo "  $font: $version"
            else
                echo "  $font: (Installed)"
            fi
        fi
    done
}

# Install a font from a ZIP URL to ~/.local/share/fonts.
# Does NOT refresh cache automatically.
# Returns 0 if installed/already present, 1 on failure.
font_zip_install() {
    local name="$1"
    local url="$2"
    local font_dir="$HOME/.local/share/fonts/$name"

    # Skip if already exists on disk AND registered in system
    if [[ -d "$font_dir" ]] && [[ -n "$(ls -A "$font_dir" 2>/dev/null)" ]]; then
        if fc-list : family | grep -qi "$name"; then
            return 0
        fi
    fi

    print_info "Installing $name..."
    mkdir -p "$font_dir"
    local tmp_zip=$(mktemp)
    if wget -q "$url" -O "$tmp_zip"; then
        unzip -oj "$tmp_zip" "*.ttf" "*.otf" "*.ttc" -d "$font_dir" > /dev/null 2>&1
        rm "$tmp_zip"
        return 0
    else
        print_error "Failed to download $name from $url"
        return 1
    fi
}

# High-level helper to install a list of fonts from ZIP URLs.
# Usage: quiet_font_install "Name1|URL1" "Name2|URL2" ...
quiet_font_install() {
    local needs_refresh=false
    local font_names=()

    for font_entry in "$@"; do
        local font_name="${font_entry%%|*}"
        local font_url="${font_entry#*|}"
        font_names+=("$font_name")
        
        if font_zip_install "$font_name" "$font_url"; then
            needs_refresh=true
        fi
    done

    if [ "$needs_refresh" = true ]; then
        print_info "Refreshing font cache..."
        fc-cache -f > /dev/null
    fi

    # Show summary
    print_font_versions "${font_names[@]}"
}
