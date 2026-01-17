#!/bin/bash

# Script to install Gemini CLI.
# Pre-requisites: dev-tools-10-nodejs.sh (for npm).
# This corresponds to the "Development Tools (CLI)" -> "AI & LLM Tools" category in SOFTWARE_INDEX.md.

APP_NAME="Gemini CLI"
APP_COMMAND="gemini"

install_gemini() {
    # Install Gemini CLI via npm
    # This assumes Node.js and npm are already installed (handled by nodejs.sh).
    npm install -g @google/gemini-cli --silent > /dev/null 2>&1

    # Ensure gemini command is available for extension installation
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"
    fi

    # Install extensions
    print_info "Installing Gemini CLI extensions..."
    gemini extensions install https://github.com/gemini-cli-extensions/conductor --silent > /dev/null 2>&1
    gemini extensions install https://github.com/gemini-cli-extensions/nanobanana --silent > /dev/null 2>&1
    gemini extensions install https://github.com/ChromeDevTools/chrome-devtools-mcp --silent > /dev/null 2>&1
}

# Source shared installation helper
