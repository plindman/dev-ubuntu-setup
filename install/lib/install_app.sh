#!/bin/bash

# Shared installation helper for GUI applications.
# Source this file at the end of app-specific install scripts.
#
# Required variables in app script:
#   APP_NAME - Human-readable name of the application
#   APP_COMMAND - Command(s) to verify installation:
#                 - Single command: "google-chrome"
#                 - Multiple commands: ("curl" "wget")
#                 - Optional: if not set, verification is skipped with warning
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
# If APP_COMMAND is array, use first element; otherwise use the single command
if [[ "$(declare -p APP_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
    FIRST_CMD="${APP_COMMAND[0]}"
else
    FIRST_CMD="$APP_COMMAND"
fi

# google-chrome -> install_google_chrome
APP_INSTALL_FUNC="install_$(echo "$FIRST_CMD" | tr '-' '_')"

# Verification function
verify_commands() {
    local cmds=("$@")
    for cmd in "${cmds[@]}"; do
        if ! command_exists "$cmd"; then
            return 1
        fi
    done
    return 0
}

# Main installation logic
print_header "Starting installation of $APP_NAME"

# Check if APP_COMMAND is set
if [[ -z "${APP_COMMAND:-}" ]]; then
    # No verification command - just install
    print_warning "No verification command set for $APP_NAME. Skipping pre-install check."
    $APP_INSTALL_FUNC
    print_warning "$APP_NAME installation complete but not verified."
elif [[ "$(declare -p APP_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
    # Array of commands - verify all
    if verify_commands "${APP_COMMAND[@]}"; then
        print_color "$GREEN" "$APP_NAME is already installed. Skipping."
    else
        $APP_INSTALL_FUNC
        if verify_commands "${APP_COMMAND[@]}"; then
            print_color "$GREEN" "$APP_NAME installation complete."
        else
            print_color "$RED" "$APP_NAME installation failed."
            exit 1
        fi
    fi
else
    # Single command
    if command_exists "$APP_COMMAND"; then
        print_color "$GREEN" "$APP_NAME is already installed. Skipping."
    else
        $APP_INSTALL_FUNC
        if command_exists "$APP_COMMAND"; then
            print_color "$GREEN" "$APP_NAME installation complete."
        else
            print_color "$RED" "$APP_NAME installation failed."
            exit 1
        fi
    fi
fi
