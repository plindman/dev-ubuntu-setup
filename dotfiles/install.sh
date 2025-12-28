#!/bin/bash

# Bootstrap script for dotfiles using chezmoi.
# Wraps the official one-liner for easy execution.

set -e

# Default to current user if argument not provided, or prompt
if [ -z "$1" ]; then
    echo "Usage: $0 <github_username>"
    echo "Please provide your GitHub username where the dotfiles are hosted."
    read -p "GitHub Username: " GITHUB_USERNAME
else
    GITHUB_USERNAME="$1"
fi

if [[ -z "$GITHUB_USERNAME" ]]; then
    echo "Error: GitHub username is required."
    exit 1
fi

echo "Bootstrapping dotfiles for user: $GITHUB_USERNAME"

# Run the official chezmoi init and apply command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "$GITHUB_USERNAME"
