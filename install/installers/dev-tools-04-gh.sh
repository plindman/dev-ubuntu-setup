#!/bin/bash

# Script to install GitHub CLI.
# This corresponds to the "Development Tools (CLI)" -> "Git" category in SOFTWARE_INDEX.md.

APP_NAME="GitHub CLI (gh)"
APP_COMMAND="gh"

install_gh() {
    # Ensure wget is present
    if ! command_exists "wget"; then
        install_and_show_versions wget
    fi

    # Use add_apt_repo helper for repository and GPG setup
    add_apt_repo "github-cli" \
        "https://cli.github.com/packages/githubcli-archive-keyring.gpg" \
        "[arch=$(dpkg --print-architecture)] https://cli.github.com/packages stable main"

    # Use our helper for the actual install
    install_and_show_versions gh
}

# Source shared installation helper
