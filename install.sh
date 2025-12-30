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
source "$MY_DIR/install/lib/module_runner.sh"

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
    install_category "devtools"
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
    install_category "desktop"
    install_category "devtools"
    install_category "apps"
    print_header "Full Installation Complete!"
    print_info "Note: Optional packages (like TexLive) were NOT installed. Use --optional to install them."
}

# --- Interactive Menu ---

show_menu() {
    clear
    echo "--------------------------------------------------"
    echo "  Development Workstation Setup"
    echo "--------------------------------------------------"
    echo "Please select which categories to install:"
    echo "  1) System Utilities"
    echo "  2) CLI Development Tools"
    echo "  3) Desktop Components"
    echo "  4) GUI Applications"
    echo "  5) Optional Software (Large/Heavy)"
    echo "  A) Install ALL Categories (Excludes Optional)"
    echo "  Q) Quit"
    echo "--------------------------------------------------"
    read -p "Enter your choice: " choice
    echo ""

    case "$choice" in
        1) install_system ;;
        2) install_dev_tools ;;
        3) install_desktop ;;
        4) install_apps ;;
        5) install_optional ;;
        [aA]) install_all ;;
        [qQ]) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac

    echo -e "\nPress any key to return to the menu..."
    read -n 1
    show_menu
}

# --- CLI Argument Parsing ---

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --all           Install all standard categories (excludes optional)"
    echo "  --system        Install system utilities"
    echo "  --desktop       Install desktop components"
    echo "  --dev-tools     Install CLI development tools"
    echo "  --apps          Install GUI applications"
    echo "  --optional      Install optional/heavy software"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "If no arguments are provided, an interactive menu will be displayed."
    echo ""
    echo "Examples:"
    echo "  $0 --all                    # Install standard set"
    echo "  $0 --optional               # Install optional components"
    echo "  $0                          # Interactive menu"
}

# Parse command line arguments
if [[ $# -eq 0 ]]; then
    # No arguments - show interactive menu
    show_menu
else
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                install_all
                exit 0
                ;;
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
