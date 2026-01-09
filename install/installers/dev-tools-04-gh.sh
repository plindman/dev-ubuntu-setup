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

    # Verbatim command from official GitHub CLI documentation for repository setup
    sudo mkdir -p -m 755 /etc/apt/keyrings
    local out=$(mktemp)
    wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg
    cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    sudo mkdir -p -m 755 /etc/apt/sources.list.d
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    
    sudo apt-get -qq update

    # Use our helper for the actual install
    install_and_show_versions gh
}

# Source shared installation helper
