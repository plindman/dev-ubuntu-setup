#!/bin/bash
# Test fonts against the real local machine state using the library logic.

set -e

# Identify locations
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Load library

source "$PROJECT_ROOT/install/lib/module_runner.sh"



echo "=== Testing Local Font Status ==="



APT_FONTS=("fonts-ibm-plex" "fonts-noto" "fonts-texgyre" "fonts-lmodern" "fonts-dejavu")

MANUAL_FONTS=("FiraCode" "JetBrainsMono" "Inter" "EB Garamond" "Libertinus")



echo "System (APT) Font Versions:"



print_apt_package_versions "${APT_FONTS[@]}"







echo ""



print_font_versions "${MANUAL_FONTS[@]}"







# Verification check

echo ""

MISSING=false

if ! fonts_installed "${MANUAL_FONTS[@]}"; then

    echo "❌ Some manual fonts are missing."

    print_missing_fonts "${MANUAL_FONTS[@]}"

    MISSING=true

fi



for pkg in "${APT_FONTS[@]}"; do

    if ! dpkg -l "$pkg" > /dev/null 2>&1; then

        echo "❌ System package missing: $pkg"

        MISSING=true

    fi

done



if [ "$MISSING" = false ]; then

    echo "✅ All expected fonts are installed."

    exit 0

else

    exit 1

fi
