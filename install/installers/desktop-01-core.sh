#!/bin/bash
APP_NAME="Desktop Core Components"
APP_COMMAND="gnome-tweaks"

install_desktop_core() {
    quiet_apt_install gnome-tweaks gnome-shell-extension-manager libsecret-tools gnome-keyring
}
