#!/bin/bash

# Shared installation helper for GUI applications.
# Source this file at the end of app-specific install scripts.
#
# Required variables in app script:
#   APP_NAME - Human-readable name of the application
#   APP_COMMAND - Command to verify installation (e.g., "google-chrome")
#
# Required function in app script:
#   install_<app>() - Function containing installation commands

set -e

# Set repository root and source helpers
if [[ -z "${REPO_ROOT:-}" ]]; then
    REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

source "$REPO_ROOT/lib/helpers.sh"

# Derive install function name from command name
# google-chrome -> install_google_chrome
APP_INSTALL_FUNC="install_$(echo "$APP_COMMAND" | tr '-' '_')"

# Main installation logic
print_header "Starting installation of $APP_NAME"

# Check if already installed
if command_exists "$APP_COMMAND"; then
    print_color "$GREEN" "$APP_NAME is already installed. Skipping."
else
    # Run app-specific installation function
    $APP_INSTALL_FUNC

    # Verify installation
    if command_exists "$APP_COMMAND"; then
        print_color "$GREEN" "$APP_NAME installation complete."
    else
        print_color "$RED" "$APP_NAME installation failed."
        exit 1
    fi
fi
