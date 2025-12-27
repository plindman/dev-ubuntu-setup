#!/bin/bash
#
# Output functions for colored output and messages.

# --- Color codes ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Output Functions ---

# Print colored output
print_color() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Print a section header
print_header() {
    print_color "$BLUE" "\n=== $1 ==="
}

# Print info message
print_info() {
    print_color "$BLUE" "INFO: $1"
}

# Print success message
print_success() {
    print_color "$GREEN" "SUCCESS: $1"
}

# Print warning message
print_warning() {
    print_color "$YELLOW" "WARNING: $1"
}

# Print error message
print_error() {
    print_color "$RED" "ERROR: $1" >&2
}
