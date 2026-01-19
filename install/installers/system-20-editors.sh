#!/bin/bash

# Script to install all CLI editors: nano, micro, and neovim.
# This corresponds to the "System" -> "Editors" category in SOFTWARE_INDEX.md.

APP_NAME="CLI Editors"
APP_COMMAND=("nano" "micro" "nvim" "notepadqq")

install_editors() {
    quiet_apt_install nano micro neovim notepadqq
}
