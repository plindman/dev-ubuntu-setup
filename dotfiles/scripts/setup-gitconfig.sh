#!/bin/bash

# Interactive setup script for .gitconfig
# Prompts for user identity if .gitconfig doesn't exist

set -e

# Source local output helpers
source "$(dirname "${BASH_SOURCE[0]}")/../lib/output.sh"

print_header "Git Configuration Setup"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_FILE="$DOTFILES_DIR/.gitconfig.template"
TARGET_FILE="$HOME/.gitconfig"


# Check if .gitconfig already exists
if [ -f "$TARGET_FILE" ]; then
    print_info "Git config already exists at $TARGET_FILE"
    print_info "Skipping setup."
    exit 0
fi

# Prompt for user information
print_color "$CYAN" "Enter your Git user name:"
read -r "?Name: " GIT_NAME

print_color "$CYAN" "Enter your Git email:"
read -r "?Email: " GIT_EMAIL

# Validate input
if [[ -z "$GIT_NAME" ]]; then
    print_error "Name cannot be empty"
    exit 1
fi

if [[ -z "$GIT_EMAIL" ]]; then
    print_error "Email cannot be empty"
    exit 1
fi

# Read template and replace placeholders
print_color "$GREEN" "Creating $TARGET_FILE..."

sed -e "s|__GIT_NAME__|$GIT_NAME|g" \
    -e "s|__GIT_EMAIL__|$GIT_EMAIL|g" \
    "$TEMPLATE_FILE" > "$TARGET_FILE"

print_success "Git configuration created successfully!"
print_info "Location: $TARGET_FILE"
print_info "You can edit it manually to add more settings."
