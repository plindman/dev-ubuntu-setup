#!/bin/bash

# Script to install Networking Tools.
# This corresponds to the "System" -> "Networking Tools" category in SOFTWARE_INDEX.md.

APP_NAME="Networking Tools"
APP_COMMAND=("curl" "wget")

install_networking_tools() {
    quiet_apt_install curl wget
}

# Source shared installation helper
