#!/bin/bash
APP_NAME="Desktop Core Components"
APP_COMMAND="gnome-tweaks"

install_desktop_core() {
    install_and_show_versions gnome-tweaks gnome-shell-extension-manager libsecret-tools gnome-keyring
}
