#!/bin/bash
#
# Output formatting functions for dotfiles scripts.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print a header
print_header() {
    echo ""
    echo -e "${BLUE}==================================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}==================================================${NC}"
    echo ""
}

# Print with color
print_color() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Print info
print_info() {
    print_color "$BLUE" "INFO: $1"
}

# Print success
print_success() {
    print_color "$GREEN" "SUCCESS: $1"
}

# Print warning
print_warning() {
    print_color "$YELLOW" "WARNING: $1"
}

# Print error
print_error() {
    print_color "$RED" "ERROR: $1"
}
