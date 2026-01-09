#!/bin/bash

# Script to install Claude Code.
# Pre-requisites: dev-tools-10-nodejs.sh (for npm).
# This corresponds to the "Development Tools (CLI)" -> "AI & LLM Tools" category in SOFTWARE_INDEX.md.

APP_NAME="Claude Code"
APP_COMMAND="claude"

install_claude() {
    # Install Claude Code via its official script
    # https://code.claude.com/docs/en/setup
    curl -fsSL https://claude.ai/install.sh | bash
}

# Source shared installation helper
