#!/bin/bash

# Script to install TexLive (Full).
# This corresponds to the "Optional" category.
# Warning: This is a very large installation (~5GB).

APP_NAME="TexLive (Full)"
APP_COMMAND="pdflatex"

install_texlive() {
    quiet_apt_install texlive-full
}
