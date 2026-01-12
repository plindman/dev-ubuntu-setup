#!/bin/bash

# Script to install system services.
# This corresponds to the "System" -> "System Services" category in SOFTWARE_INDEX.md.

APP_NAME="System Services"
APP_COMMAND="ssh"

install_services() {
    quiet_apt_install openssh-server
}

# Source shared installation helper
