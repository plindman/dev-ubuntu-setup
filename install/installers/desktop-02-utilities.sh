#!/bin/bash
APP_NAME="Desktop Utilities"
APP_COMMAND="nemo"

install_desktop_utilities() {
    quiet_apt_install nemo synaptic
}
