#!/bin/bash

# Script to install Git.
# This corresponds to the "Development Tools (CLI)" -> "Git" category in SOFTWARE_INDEX.md.

APP_NAME="Git"
APP_COMMAND="git"

install_git() {
    install_and_show_versions git-all
}

# Source shared installation helper
