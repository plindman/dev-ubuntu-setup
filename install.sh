#!/bin/bash

# Main installation script for the Development Workstation Setup

set -e # Exit immediately if a command exits with a non-zero status

# --- Helper Functions ---

# Function to display a section header
print_header() {
    echo -e "\n=========================================="
    echo -e "  $1"
    echo -e "==========================================\n"
}

# Function to run scripts in a given directory
run_category_scripts() {
    local category_dir="$1"
    if [ -d "$category_dir" ]; then
        echo "Installing components from $category_dir..."
        for script in "$category_dir"/*.sh; do
            if [ -f "$script" ]; then
                print_header "Running $(basename "$script")"
                # For now, just echo the script name. Later, we'll execute it.
                # bash "$script"
                echo "Executing script: $script (placeholder)"
            fi
        done
    else
        echo "Warning: Category directory '$category_dir' not found. Skipping."
    fi
}

# --- Installation Categories ---

install_system() {
    print_header "Installing System Utilities"
    run_category_scripts "$(dirname "$0")/install/system"
}

install_services() {
    print_header "Installing Services"
    run_category_scripts "$(dirname "$0")/install/services"
}

install_desktop() {
    print_header "Installing Desktop Components"
    run_category_scripts "$(dirname "$0")/install/desktop"
}

install_dev_tools() {
    print_header "Installing CLI Development Tools"
    run_category_scripts "$(dirname "$0")/install/dev-tools"
}

install_dev_apps() {
    print_header "Installing GUI Development Applications"
    run_category_scripts "$(dirname "$0")/install/dev-apps"
}

install_apps() {
    print_header "Installing General Applications"
    run_category_scripts "$(dirname "$0")/install/apps"
}

# --- Main Menu ---

show_menu() {
    clear
    echo "--------------------------------------------------"
    echo "  Development Workstation Setup"
    echo "--------------------------------------------------"
    echo "Please select which categories to install:"
    echo "  1) System Utilities"
    echo "  2) Services"
    echo "  3) Desktop Components"
    echo "  4) CLI Development Tools"
    echo "  5) GUI Development Applications"
    echo "  6) General Applications"
    echo "  A) Install ALL Categories"
    echo "  Q) Quit"
    echo "--------------------------------------------------"
    read -p "Enter your choice: " choice
    echo ""

    case "$choice" in
        1) install_system ;;
        2) install_services ;;
        3) install_desktop ;;
        4) install_dev_tools ;;
        5) install_dev_apps ;;
        6) install_apps ;;
        [aA])
            install_system
            install_services
            install_desktop
            install_dev_tools
            install_dev_apps
            install_apps
            ;;
        [qQ]) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac

    echo -e "\nPress any key to return to the menu..."
    read -n 1
    show_menu # Loop back to menu
}

# --- Execution ---

if [[ "$1" == "--all" ]]; then
    # Non-interactive "install all" option
    print_header "Starting Full Automated Installation"
    install_system
    install_services
    install_desktop
    install_dev_tools
    install_dev_apps
    install_apps
    print_header "Full Installation Complete!"
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: ./install.sh [--all | -h | --help]"
    echo "  --all    : Perform a full, non-interactive installation of all categories."
    echo "  -h, --help : Show this help message."
    echo "If no arguments are provided, an interactive menu will be displayed."
else
    # Interactive menu by default
    show_menu
fi
