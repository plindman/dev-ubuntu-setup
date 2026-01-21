#!/bin/bash

# Script to install agent-browser (headless browser automation CLI for AI agents).
# Pre-requisites: dev-tools-10-nodejs.sh (for npm).
# This corresponds to the "Development Tools (CLI)" -> "Addon Tools" category.

APP_NAME="agent-browser"
APP_COMMAND="agent-browser"

install_agent_browser() {
    print_info "Installing $APP_NAME..."

    # Install via npm
    npm install -g agent-browser

    # Download Chromium bundle with system dependencies
    agent-browser install --with-deps

    print_success "$APP_NAME installation complete."
}
