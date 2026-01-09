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

# Set script directory
MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source module runner (which sources helpers)
source "$MY_DIR/../install/lib/module_runner.sh"

# --- Installation Wrappers ---

install_system() {
    sudo apt-get -qq update
    install_category "system"
}

install_desktop() {
    sudo apt-get -qq update
    install_category "desktop"
}

install_dev_tools() {
    sudo apt-get -qq update
    install_category "dev-tools"
}

install_apps() {
    sudo apt-get -qq update
    install_category "apps"
}

install_optional() {
    sudo apt-get -qq update
    install_category "optional"
}

install_all() {
    print_header "Starting Full Installation"
    sudo apt-get -qq update
    install_category "system"
    install_category "dev-tools"
    install_category "desktop"
    install_category "apps"
    print_header "Full Installation Complete!"
    print_info "Note: Optional packages (like TexLive) were NOT installed. Use --optional to install them."
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
    echo "  --optional      Install optional/heavy software"
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
            --optional)
                install_optional
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
