#!/bin/bash

# Script to install TeXstudio.
# This corresponds to the "Optional" category.

APP_NAME="TeXstudio"
APP_COMMAND="texstudio"

install_texstudio() {
    install_and_show_versions texstudio
}

post_install_info_texstudio() {
    echo "To configure TeXstudio for optimal use:"
    echo "1. Open TeXstudio."
    echo "2. Go to Options -> Configure TeXstudio -> Build."
    echo "3. Change the 'Default Compiler' to 'XeLaTeX'."
}
