#!/bin/bash

# Script to install Gemini CLI.
# This corresponds to the "Development Tools (CLI)" -> "AI & LLM Tools" category in SOFTWARE_INDEX.md.

APP_NAME="Gemini CLI"
APP_COMMAND="gemini"

install_gemini() {
    # Install Gemini CLI via npm
    # This assumes Node.js and npm are already installed (handled by nodejs.sh).
    npm install -g @google/gemini-cli
}

# Source shared installation helper
