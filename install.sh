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

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source helper functions
source "$REPO_ROOT/install/lib/helpers.sh"

# Source category orchestrators
source "$REPO_ROOT/install/cat-system.sh"
source "$REPO_ROOT/install/cat-desktop.sh"
source "$REPO_ROOT/install/cat-dev-tools.sh"
source "$REPO_ROOT/install/cat-apps.sh"

# --- Installation Functions ---

install_all() {
    print_header "Starting Full Installation"
    install_system
    install_desktop
    install_dev_tools
    install_apps
    print_header "Full Installation Complete!"
}

# --- Interactive Menu ---

show_menu() {
    clear
    echo "--------------------------------------------------"
    echo "  Development Workstation Setup"
    echo "--------------------------------------------------"
    echo "Please select which categories to install:"
    echo "  1) System Utilities"
    echo "  2) Desktop Components"
    echo "  3) CLI Development Tools"
    echo "  4) GUI Applications"
    echo "  A) Install ALL Categories"
    echo "  Q) Quit"
    echo "--------------------------------------------------"
    read -p "Enter your choice: " choice
    echo ""

    case "$choice" in
        1) install_system ;;
        2) install_desktop ;;
        3) install_dev_tools ;;
        4) install_apps ;;
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
    echo "  --all           Install all categories"
    echo "  --system        Install system utilities"
    echo "  --desktop       Install desktop components"
    echo "  --dev-tools     Install CLI development tools"
    echo "  --apps          Install GUI applications"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "If no arguments are provided, an interactive menu will be displayed."
    echo ""
    echo "Examples:"
    echo "  $0 --all                    # Install everything"
    echo "  $0 --system --dev-tools     # Install system and dev-tools only"
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
