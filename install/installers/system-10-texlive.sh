#!/bin/bash

# Script to install TexLive (Full).
# This corresponds to the "Optional" category.
# Warning: This is a very large installation (~5GB).

APP_NAME="TexLive (Full)"
APP_COMMAND="pdflatex"

install_texlive() {
    print_warning "This will install 'texlive-full' which requires ~5GB of disk space."
    print_warning "This process may take a long time depending on your internet connection."
    
    # Check for non-interactive execution or ask for confirmation
    if [[ -z "$CI" && -z "$NONINTERACTIVE" ]]; then
        read -p "Are you sure you want to continue? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled."
            return 0
        fi
    fi

    quiet_apt_install texlive-full
}
