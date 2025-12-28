#!/bin/bash

# Script to install all CLI editors: nano, micro, and neovim.
# This corresponds to the "System" -> "Editors" category in SOFTWARE_INDEX.md.

APP_NAME="CLI Editors"
APP_COMMAND=("nano" "micro" "nvim")

install_editors() {
    install_and_show_versions nano micro neovim
}

# Source shared installation helper
