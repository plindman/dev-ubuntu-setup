#!/bin/bash

# Mock helpers
print_color() { echo "$2"; }
NC=""
GREEN=""
YELLOW=""

# Source the function to test
source install/lib/fonts.sh

# Mock fc-list command
fc-list() {
    local arg="$1"
    # Return real simulated outputs discovered from probing
    if [[ "$arg" == *FiraCode* ]]; then
        echo "FiraCode Nerd Font:version=Version 3.2.1"
    elif [[ "$arg" == *Inter* ]]; then
        echo "Inter Variable:fontversion=262210"
    elif [[ "$arg" == *Libertinus* ]]; then
        echo "Libertinus Serif:version=Version 7.040"
    else
        echo ""
    fi
}

echo "Testing print_font_versions..."
print_font_versions "FiraCode" "Inter" "Libertinus"
