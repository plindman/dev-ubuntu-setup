#!/bin/bash

# Script to install system services.
# This corresponds to the "System" -> "System Services" category in SOFTWARE_INDEX.md.

APP_NAME="System Services"
APP_COMMAND="ssh"

install_services() {
    install_and_show_versions openssh-server
}

# Source shared installation helper
