#!/bin/bash
#
# Helper functions for colored output and package management in installation scripts.

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to install apt packages silently and show their versions.
# This replaces `sudo apt-get -q install -y ...`
install_and_show_versions() {
  local packages=("$@") # Get all arguments as an array of packages
  print_color "$GREEN" "Installing/Upgrading apt packages: ${packages[*]}..."
  sudo apt-get -qq install -y "${packages[@]}"
  
  if [ $? -eq 0 ]; then
      print_color "$GREEN" "Successfully installed/upgraded packages."
      print_color "$GREEN" "Installed Versions:"
      dpkg-query -W -f='  ${Package}: ${Version}\n' "${packages[@]}" || \
          print_color "$YELLOW" "Warning: Could not query versions for all packages."
  else
      print_color "$RED" "Error: Failed to install/upgrade apt packages: ${packages[*]}."
      return 1 # Indicate failure
  fi
}
