#!/bin/bash

# Main installation script for the Development Workstation Setup
# Usage: ./install.sh [options]
#   --all           Install all categories
#   --system        Install system utilities
#   --desktop       Install desktop components
#   --dev-tools     Install CLI development tools
#   --apps          Install GUI applications
#   -h, --help      Show this help message
# If no arguments provided, show interactive menu

set -e

# Ensure non-interactive for all apt calls
export DEBIAN_FRONTEND=noninteractive

# Set script directory
MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source module runner (which sources helpers)
source "$MY_DIR/../lib/module_runner.sh"

# --- Installation Wrappers ---

install_system() {
    install_category "system"
}

install_desktop() {
    install_category "desktop"
}

install_dev_tools() {
    install_category "dev-tools"
}

install_apps() {
    install_category "apps"
}

install_all() {
    print_header "Starting Full Installation"
    quiet_apt_update
    install_category "system"
    install_category "dev-tools"
    install_category "desktop"
    install_category "apps"
    print_header "Full Installation Complete!"
}

# --- CLI Argument Parsing ---

# Allow menu.sh to source this file without triggering execution
if [[ "${MENU_MODE:-}" == "true" ]]; then
    return 0
fi

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --system        Install system utilities"
    echo "  --desktop       Install desktop components"
    echo "  --dev-tools     Install CLI development tools"
    echo "  --apps          Install GUI applications"
    echo "  --list <cat>    List apps in a category"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "If no arguments are provided, all standard categories are installed."
    echo "For an interactive experience, run: ./bin/menu.sh"
}

# Parse command line arguments
if [[ $# -eq 0 ]]; then
    # No arguments - default to install all
    install_all
else
    # Run update once if we are doing any installations
    if [[ "$1" != "--list" && "$1" != "-h" && "$1" != "--help" ]]; then
        quiet_apt_update
    fi

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --system)
                install_system
                shift
                ;;
            --desktop)
                install_desktop
                shift
                ;;
            --dev-tools)
                install_dev_tools
                shift
                ;;
            --apps)
                install_apps
                shift
                ;;
            --list)
                if [[ -n "$2" && "$2" != --* ]]; then
                    list_category_apps "$2"
                    shift 2
                else
                     echo "Error: --list requires a category argument"
                     exit 1
                fi
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "Error: Unknown option '$1'"
                show_help
                exit 1
                ;;
        esac
    done
fi
