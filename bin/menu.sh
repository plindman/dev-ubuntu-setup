#!/bin/bash

# Interactive Menu for the Development Workstation Setup
# Provides a UI wrapper for the command-line installer.

set -e

# Set script directory
MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the main installer functions (it contains the categories)
# We source it in a way that doesn't trigger its auto-run
export MENU_MODE=true
source "$MY_DIR/install.sh"

show_menu() {
    clear
    echo "--------------------------------------------------"
    echo "  Development Workstation Setup (Interactive)"
    echo "--------------------------------------------------"
    echo "Please select which categories to install:"
    echo "  1) System Utilities"
    echo "  2) CLI Development Tools"
    echo "  3) Desktop Components"
    echo "  4) GUI Applications"
    echo "  A) Install ALL Categories"
    echo "  Q) Quit"
    echo "--------------------------------------------------"
    read -p "Enter your choice: " choice
    echo ""

    case "$choice" in
        1) install_system ;;
        2) install_dev_tools ;;
        3) install_desktop ;;
        4) install_apps ;;
        [aA]) install_all ;;
        [qQ]) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac

    echo -e "\nPress any key to return to the menu..."
    read -n 1
    show_menu
}

show_menu
